#!/usr/bin/env bash  # This is fine, since zsh can run bash scripts

selected=$(cat ~/DotFiles/scripts/.tmux-cht-languages ~/DotFiles/scripts/.tmux-cht-command | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

read -rp "Enter Query: " query

if grep -q "$selected" ~/DotFiles/scripts/.tmux-cht-languages; then
    query=$(echo "$query" | tr ' ' '+')
    tmux neww "curl cht.sh/$selected/$query && while true; do sleep 1; done"
else
    tmux neww "curl -s cht.sh/$selected~$query | less"
fi
