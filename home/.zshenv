# ~/.zshenv

# Source Cargo environment
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Static Homebrew environment (Replaces dynamic brew shellenv to save ~180ms)
if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew/api"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH+:$INFOPATH}"
fi

# Pyenv Paths
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
[[ -d "${PYENV_ROOT}/shims" ]] && export PATH="${PYENV_ROOT}/shims:${PATH}"

# Tool Directories
export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="$HOME/.sdkman"
export PNPM_HOME="$HOME/Library/pnpm"
export GOPATH="$HOME/Tools/go"
export GOBIN="$GOPATH/bin"

# Consolidate PATH additions into a single declaration (prevents redundant string ops)
typeset -U path  # Automatically keeps PATH unique (no duplicates)
path=(
  $PNPM_HOME
  $GOBIN
  $HOME/Tools/zig-dev
  $HOME/.local/bin
  /sbin
  /usr/sbin
  $path
)

# ---------------------------------------------------------------------------
# XDG base directories, and the tools that can be told to honour them.
# Each var below moves a file that would otherwise be dropped in $HOME.
# Unset any one of these and the tool reverts to its old ~/ location.
# ---------------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# History and state
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"   # CPython 3.13+
export PSQL_HISTORY="$XDG_STATE_HOME/psql/history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite/history"
export REDISCLI_HISTFILE="$XDG_STATE_HOME/redis/history"
export _Z_DATA="$XDG_STATE_HOME/z/data"                  # oh-my-zsh z plugin
export XAUTHORITY="$XDG_STATE_HOME/X11/xauthority"

# Config
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export BOTO_CONFIG="$XDG_CONFIG_HOME/boto/config"

# Tool homes
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export IPYTHONDIR="$XDG_DATA_HOME/ipython"
