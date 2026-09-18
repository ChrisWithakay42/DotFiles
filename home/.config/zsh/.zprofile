# ~/.zprofile — login shells. Runs AFTER /etc/zprofile.
#
# /etc/zprofile runs `path_helper`, which REBUILDS PATH with /etc/paths and
# /etc/paths.d/* first. That happens after ~/.zshenv, so anything .zshenv
# prepends gets demoted below /usr/bin. PATH entries that must win belong
# here, not there. Order below is deliberate: last prepend wins.

# Homebrew. Static equivalent of `eval "$(brew shellenv)"` — same result,
# without spawning a subprocess on every login shell (~180ms). Re-prepended
# here because path_helper demoted the copy set in ~/.zshenv.
if [[ -d /opt/homebrew ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export MANPATH="/opt/homebrew/share/man${MANPATH:+:$MANPATH}"
  export INFOPATH="/opt/homebrew/share/info${INFOPATH:+:$INFOPATH}"
fi

# JetBrains Toolbox CLI launchers
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
  export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# User binaries, then pyenv shims — last, so they beat everything above.
[[ -d "$HOME/.local/bin" ]]    && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.pyenv/shims" ]]  && export PATH="$HOME/.pyenv/shims:$PATH"

# Collapse any duplicates introduced above (typeset -U keeps PATH unique).
typeset -U path
