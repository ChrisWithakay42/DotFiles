# Bootstrap only. zsh always reads ~/.zshenv first, before ZDOTDIR is known;
# everything else lives in $ZDOTDIR and is read from there automatically.
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
[[ -f "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
