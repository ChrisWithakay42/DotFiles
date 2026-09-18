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
