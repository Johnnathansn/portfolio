package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type ListItem struct {
	Name string
	Done bool
}

type TodoList struct {
	items []ListItem
}

func (list *TodoList) newItem(name string, done bool) []ListItem {
	list.items = append(list.items, ListItem{
		Name: name,
		Done: done,
	})

	return list.items
}

func (list *TodoList) listItems() {
	if len(list.items) == 0 {
		fmt.Println("You have 0 Todos")
		return
	}

	count := 1
	for _, v := range list.items {
		fmt.Printf("%d - Todo: %s Done: %t\n", count, v.Name, v.Done)
		count++
	}
}

func optionsMenuDescription() {
	fmt.Println("What would you like to do?")
	fmt.Println("1 - Add a Todo")
	fmt.Println("2 - Mark/Unmark Todo as Done")
	fmt.Println("3 - leave")
}

func menuAddItem(list *TodoList) (result string, err error) {
	input := bufio.NewReader(os.Stdin)
	fmt.Println("item: ")
	text, _ := input.ReadString('\n')
	text = strings.TrimRight(text, "\r\n")

	if text == "" {
		return "", errors.New("Invalid. write something.")
	}
	list.newItem(text, false)

	return text, nil
}

func toggleDone(list *TodoList) bool {
	input := bufio.NewReader(os.Stdin)
	fmt.Println("Which Todo to mark/unmark?")
	text, _ := input.ReadString('\n')
	text = strings.TrimRight(text, "\r\n")

	intVal, err := strconv.Atoi(text)
	if err != nil {
		fmt.Println("Not A Number")
		return false
	}

	if (intVal) > len(list.items) {
		fmt.Println("item does not exist")
		return false
	}

	if list.items[intVal-1].Done == true {
		list.items[intVal-1].Done = false
	} else {
		list.items[intVal-1].Done = true
	}

	return true
}

func main() {

	list := TodoList{}
	argsReader := bufio.NewReader(os.Stdin)

	for {

		list.listItems()
		optionsMenuDescription()
		selectedOption, _ := argsReader.ReadString('\n')
		selectedOption = strings.TrimRight(selectedOption, "\r\n")

		switch selectedOption {
		case "1":
			_, err := menuAddItem(&list)
			if err != nil {
				fmt.Print(err, '\n')
				fmt.Println("Try Again")
				continue
			}
		case "2":
			toggleDone(&list)
		case "3":
			os.Exit(0)
		}

	}
}
