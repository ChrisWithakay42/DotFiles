# --- 1. Powerlevel10k Instant Prompt (MUST BE FIRST) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# --- 2. Oh My Zsh Performance Flags ---
DISABLE_AUTO_UPDATE="true"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Selected OMZ plugins
plugins=(
  git
  z
  docker
  docker-compose
  kubectl
)

# Source Oh My Zsh framework
source $ZSH/oh-my-zsh.sh

# --- 3. Highlighting & Autosuggestions ---
if [[ -f "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [[ -f "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [[ -f "$ZSH/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  source "$ZSH/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

# Source Powerlevel10k theme config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- 4. Lazy-Loaded Tools ---

# Pyenv (Lazy Loaded)
if command -v pyenv &>/dev/null; then
  pyenv() {
    unset -f pyenv
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
fi

# Virtualenvwrapper (Lazy Loaded)
_load_virtualenvwrapper() {
  unset -f workon mkvirtualenv rmvirtualenv deactivate
  
  if [[ -x /opt/homebrew/bin/python3 ]]; then
    export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3
  elif command -v python3 &>/dev/null; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
  fi

  local venv_script="/opt/homebrew/bin/virtualenvwrapper.sh"
  if [[ -f "$venv_script" ]]; then
    source "$venv_script"
  elif [[ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]]; then
    source "$HOME/.local/bin/virtualenvwrapper.sh"
  elif command -v virtualenvwrapper.sh &>/dev/null; then
    source "$(which virtualenvwrapper.sh)"
  fi
}

workon() { _load_virtualenvwrapper; workon "$@"; }
mkvirtualenv() { _load_virtualenvwrapper; mkvirtualenv "$@"; }
rmvirtualenv() { _load_virtualenvwrapper; rmvirtualenv "$@"; }
deactivate() { _load_virtualenvwrapper; deactivate "$@"; }

# NVM Lazy Loading
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  load_nvm() {
    unset -f nvm node npm yarn pnpm npx
    \. "$NVM_DIR/nvm.sh" --no-use
    [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
    "$@"
  }
  nvm() { load_nvm nvm "$@"; }
  node() { load_nvm node "$@"; }
  npm() { load_nvm npm "$@"; }
  yarn() { load_nvm yarn "$@"; }
  pnpm() { load_nvm pnpm "$@"; }
  npx() { load_nvm npx "$@"; }
fi

# SDKMAN Lazy Loading
if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
  load_sdkman() {
    unset -f sdk java
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    "$@"
  }
  sdk() { load_sdkman sdk "$@"; }
fi

# FZF Direct Source
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# --- 5. Aliases ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../.."
alias .....="cd ../../../.."
alias lst="exa --icons -T -L 2"
alias ls="exa --icons"
alias ll="exa -l --icons"
alias la="exa -la --icons"
alias l.="exa -a | egrep '^\.'"
alias duh="du -sh * | sort -h"
alias cat="bat --style=plain"
alias vim="nvim"
alias v="nvim"
alias vi="nvim"
alias code="/Applications/vscode.app/Contents/Resources/app/bin/code"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias update="brew update && brew upgrade && brew cleanup -s && brew doctor && pnpm update -g && omz update"
alias ip="curl ifconfig.me"
alias weather="curl wttr.in/london"
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
alias kgn="kubectl get nodes"
alias kgns="kubectl get namespaces"
alias kdesc="kubectl describe"
alias klogs="kubectl logs"
alias kexec="kubectl exec -it"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias kcuc="kubectl config use-context"
alias kcgc="kubectl config get-contexts"
alias kca="kubectl apply -f ."
alias kgpa="kubectl get pods --all-namespaces"
alias kga="kubectl get all"
alias kgan="kubectl get all --all-namespaces"
alias ksys="kubectl --namespace=kube-system"
alias kpf="kubectl port-forward"
alias dc="docker-compose"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcl="docker-compose logs -f"
alias dcb="docker-compose build"
alias dcp="docker-compose ps"
alias dce="docker-compose exec"
alias ds="docker system prune -af --volumes"
alias sshconfig="nvim ~/.ssh/config"
alias zshconfig="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"
alias nvimconfig="nvim ~/.config/nvim/init.lua"
alias tmuxconfig="nvim ~/.tmux.conf"
alias ghosttyconfig="nvim ~/.config/ghostty/config"
alias p10kconfig="p10k configure"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias gadm="$HOME/Tools/gam7/gam"
alias tt="taskwarrior-tui"
alias tf="terraform"

# --- 6. Functions ---
mcd() {
  mkdir -p "$1" && cd "$1" || return
}

extract() {
  for archive in "$@"; do
    if [[ -f "$archive" ]]; then
      case "$archive" in
        *.tar.bz2) tar xvjf "$archive" ;;
        *.tar.gz) tar xvzf "$archive" ;;
        *.bz2) bunzip2 "$archive" ;;
        *.rar) unrar x "$archive" ;;
        *.gz) gunzip "$archive" ;;
        *.tar) tar xvf "$archive" ;;
        *.tbz2) tar xvjf "$archive" ;;
        *.tgz) tar xvzf "$archive" ;;
        *.zip) unzip "$archive" ;;
        *.Z) uncompress "$archive" ;;
        *.7z) 7z x "$archive" ;;
        *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file"
    fi
  done
}

bak() {
  cp "$1" "$1"_$(date +%Y%m%d%H%M%S).bak
}

# --- 7. Fabric YT & Command-Not-Found Handler ---
yt() {
  if [[ "$#" -eq 0 || "$#" -gt 2 ]]; then
    echo "Usage: yt [-t | --timestamps] youtube-link"
    echo "Use the '-t' flag to get the transcript with timestamps."
    return 1
  fi

  transcript_flag="--transcript"
  if [[ "$1" = "-t" || "$1" = "--timestamps" ]]; then
    transcript_flag="--transcript-with-timestamps"
    shift
  fi
  local video_link="$1"
  fabric -y "$video_link" $transcript_flag
}

_fabric_pattern_lazy_loader() {
  local pattern_name="$1"
  local pattern_path="$HOME/.config/fabric/patterns/$pattern_name"

  if [[ -f "$pattern_path" || -d "$pattern_path" ]]; then
    alias "$pattern_name"="fabric --pattern $pattern_name"
    shift
    fabric --pattern "$pattern_name" "$@"
    return 0
  fi

  return 1
}

command_not_found_handler() {
  if _fabric_pattern_lazy_loader "$@"; then
    return 0
  else
    printf "zsh: command not found: %s\n" "$1" >&2
    return 127
  fi
}


alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-features=OverlayScrollbar,SmoothScrolling --disable-gql --ignore-gpu-blocklist"
