#!/bin/bash



if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" =~ rxvt*|xterm* ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi


PS1="\u@\h:\w:"



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
