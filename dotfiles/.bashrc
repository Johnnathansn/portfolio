# GOLANG export
export GOPATH=$HOME/go
#export PATH=$PATH:$GOPATH/bin

# FZF Init
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# History settings
HISTTIMEFORMAT="%F %T"
HISTSIZE=10000
HISTFILESIZE=10000

# RUST export
export PATH="$HOME/.cargo/bin:$PATH"

# composer export
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# pnpm
export PNPM_HOME="/home/pennywise/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# in case vim in x11 use gvim -v
# slackware vim is not compiled with -clipboard
[[ ! -z "$DISPLAY" ]] && alias vim="gvim -v"
