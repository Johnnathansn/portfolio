package blockchain

import (
	"bytes"
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/sha256"
	"encoding/gob"
	"encoding/hex"
	"fmt"
	"log"
	"math/big"
)

type Transaction struct {
	ID      []byte
	Inputs  []TxInput
	Outputs []TxOutput
}

func (tx Transaction) Serialize() []byte {
	var encoded bytes.Buffer

	enc := gob.NewEncoder(&encoded)
	err := enc.Encode(tx)
	if err != nil {
		log.Panic(err)
	}

	return encoded.Bytes()
}

func (tx *Transaction) SetID() {
	var encoded bytes.Buffer
	var hash [32]byte

	encode := gob.NewEncoder(&encoded)
	err := encode.Encode(tx)
	Handle(err)

	hash = sha256.Sum256(encoded.Bytes())
	tx.ID = hash[:]
}

func (tx *Transaction) Hash() []byte {
	var hash [32]byte
	txCopy := *tx
	txCopy.ID = []byte{}

	hash = sha256.Sum256(txCopy.Serialize())

	return hash[:]
}

func (tx *Transaction) Verify(prevTXs map[string]Transaction) bool {
    if tx.IsCoinbase() {
        return true
    }

    for _, in := range tx.Inputs {
        if prevTXs[hex.EncodeToString(in.ID)].ID == nil {
            log.Panic("Previous transaction does not exist")
        }
    }

    txCopy := tx.TrimmedCopy()
    curve := elliptic.P256()

    for inId, in := range tx.Inputs {
        prevTx := prevTXs[hex.EncodeToString(in.ID)]
        txCopy.Inputs[inId].Signature = nil
        txCopy.Inputs[inId].PubKey = prevTx.Outputs[in.Out].PubKeyHash
        txCopy.ID = txCopy.Hash()
        txCopy.Inputs[inId].PubKey = nil

        r := big.Int{}
        s := big.Int{}
        sigLen := len(in.Signature)
        r.SetBytes(in.Signature[:(sigLen / 2)])
        s.SetBytes(in.Signature[(sigLen / 2):])

        x := big.Int{}
        y := big.Int{}
        keyLen := len(in.PubKey)
        x.SetBytes(in.PubKey[:(keyLen / 2)])
        y.SetBytes(in.PubKey[(keyLen / 2):])

        rawPubKey := ecdsa.PublicKey{curve, &x, &y}
        if ecdsa.Verify(&rawPubKey, txCopy.ID, &r, &s) == false {
            return false
        }
    }

    return true
}

func CoinbaseTx(to, data string) *Transaction {
	if data == "" {
		data = fmt.Sprintf("Coins to %s", to)
	}

	txin := TxInput{[]byte{}, -1, data}
	txout := TxOutput{100, to}

	tx := Transaction{nil, []TxInput{txin}, []TxOutput{txout}}
	tx.SetID()

	return &tx
}

func (tx *Transaction) IsCoinbase() bool {
	return len(tx.Inputs) == 1 && len(tx.Inputs[0].ID) == 0 && tx.Inputs[0].Out == -1
}

func (tx *Transaction) Sign(privKey ecdsa.PrivateKey, prevTXs map[string]Transaction) {
    if tx.IsCoinbase() {
        return
    }

    for _, in := range tx.Inputs {
        if prevTXs[hex.EncodeToString(in.ID)].ID == nil {
            log.Panic("ERROR: Previous transaction is not correct")
        }
    }
    txCopy := tx.TimmedCopy()

    for inId, in := range txCopy.Inputs {
        prevTX := prevprevTXs[hex.EncodeToString(in.ID)]
        txCopy.Inputs[inId].Signature = nil
        txCopy.Inputs[inId].PubKey = prevTX.Outputs[in.Out].PubKeyHash
        txCopy.ID = txCopy.Hash()
        txCopy.Inputs[inId].PubKey = nil

        r, s, err := ecdsa.Sign(rand.Reader, &privKey, txCopy.ID)
        Handle(err)
        signature := append(r.Bytes(), s.Bytes()...)

        tx.Inputs[inId].Signature = signature
    }
}

func (tx *Transaction) TrimmedCopy() Transaction {
    var inputs []TxInput
    var outputs []TxOutput

    for _, in := range tx.Inputs {
        inputs = append(inputs, TxInput{in.ID, in.Out, nil, nil}
    }

    for _, out := range tx.Outputs {
        outputs = append(outputs, TxOuTxOutput{out.Value, out.PubKeyHash}
    }

    txCopy := Transaction{tx.ID, inputs, outputs}

    return txCopy
}

func NewTransaction(from, to string, amount int, chain *BlockChain) *Transaction {
	var inputs []TxInput
	var outputs []TxOutput

	acc, validOutputs := chain.FindSpendableOutputs(from, amount)
	if acc < amount {
		log.Panic("Error: not enough funds")
	}

	for txid, outs := range validOutputs {
		txID, err := hex.DecodeString(txid)
		Handle(err)

		for _, out := range outs {
			input := TxInput{txID, out, from}
			inputs = append(inputs, input)
		}

	}

	outputs = append(outputs, TxOutput{amount, to})

	if acc > amount {
		outputs = append(outputs, TxOutput{acc - amount, from})
	}

	tx := Transaction{nil, inputs, outputs}
	tx.SetID()

	return &tx
}

