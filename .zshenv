# ~/.zshenv

# Set PATH, MANPATH, etc., for Homebrew. (This is usually fast)
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv environment variables (NO init commands here)
export PYENV_ROOT="$HOME/.pyenv"
# Ensure pyenv shims and bin are in PATH.
# Prepending ensures they take precedence.
if [[ -d "${PYENV_ROOT}/bin" ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
fi
if [[ -d "${PYENV_ROOT}/shims" ]]; then
  export PATH="${PYENV_ROOT}/shims:${PATH}"
fi

# NVM environment variable (NO init commands here)
export NVM_DIR="$HOME/.nvm"

# SDKMAN environment variable (NO init commands here)
export SDKMAN_DIR="/Users/chris/.sdkman" # Make sure this path is correct for your username

# PNPM environment variable (this is fine here)
export PNPM_HOME="/Users/chris/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
