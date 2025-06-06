# ~/.zshrc

# ZSH config path
export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  docker
  docker-compose
  kubectl
  fzf
  # pyenv # Keep this commented out, we're handling pyenv init manually/lazily
)

# Source Oh My Zsh (this will also run compinit)
source $ZSH/oh-my-zsh.sh

# Powerlevel10k Instant Prompt
# IMPORTANT: This block should be after sourcing Oh My Zsh and plugins,
# but before any other complex initializations or sourcing .p10k.zsh if possible.
# However, OMZ structure means p10k theme is loaded by OMZ. The instant prompt
# cache will speed things up regardless.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Powerlevel10k theme config
# This is typically done by OMZ when ZSH_THEME is set, but explicit sourcing ensures it loads.
# If OMZ already sources it correctly (which it should), this line can be redundant but harmless.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Lazy Loading & Tool Initializations ---

# Pyenv Initialization
# We only run the full `pyenv init -` if `pyenv` command is available.
# `pyenv init --path` is already handled by .zshenv PATH settings.
if command -v pyenv 1>/dev/null 2>&1; then
  # The main pyenv init for shell functions, completions etc.
  eval "$(pyenv init -)"
  # If you use pyenv-virtualenv plugin, uncomment the next line:
  # eval "$(pyenv virtualenv-init -)"
fi

# NVM (Node Version Manager) Lazy Loading
# The NVM_DIR export is already in .zshenv
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # This function will load NVM and then replace itself with the real commands.
  load_nvm() {
    unset -f nvm node npm yarn pnpm npx # Add any other node-related commands you use
    \. "$NVM_DIR/nvm.sh" --no-use # Source nvm.sh without immediately trying to `nvm use`
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Load bash_completion
    # You might want to `nvm use default` or similar here if needed,
    # or let .nvmrc files handle it when you cd into a project.
    # Example: nvm_find_nvmrc && nvm use --silent
    # Call the original command
    "$@"
  }
  nvm() { load_nvm nvm "$@"; }
  node() { load_nvm node "$@"; }
  npm() { load_nvm npm "$@"; }
  yarn() { load_nvm yarn "$@"; } # If you use Yarn
  pnpm() { load_nvm pnpm "$@"; } # If you use pnpm (though you also have global pnpm)
  npx() { load_nvm npx "$@"; }
fi

# SDKMAN Lazy Loading
# The SDKMAN_DIR export is already in .zshenv
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  # This function will load SDKMAN and then replace itself with the real command.
  load_sdkman() {
    unset -f sdk java # Add other SDKMAN managed commands if you want them to trigger load
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    # Call the original command
    "$@"
  }
  sdk() { load_sdkman sdk "$@"; }
  # You can add more for java, gradle, etc., if you want them to auto-load SDKMAN
  # java() { load_sdkman java "$@"; }
  # Otherwise, SDKMAN shims (from SDKMAN_DIR/candidates/.../bin) should generally work
  # once SDKMAN_DIR/bin is in PATH (done by sdkman-init.sh).
fi

# FZF (already good)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases & Functions (Keep your existing ones here)
# Make sure none of your aliases or functions run extremely slow commands on definition.

# --- Your Aliases ---
alias ઝ="cd ~ && clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
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
alias code="/Applications/vscode.app/Contents/Resources/app/bin/code" # or code-insiders if you use that
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-features=OverlayScrollbar,SmoothScrolling --disable-gql --ignore-gpu-blocklist"
alias update="brew update && brew upgrade && brew cleanup -s && brew doctor && pnpm update -g && omz update"
alias ip="curl ifconfig.me"
alias weather="curl wttr.in/toronto" # Corrected 'toronto'
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
alias kc அதாவது="kubectl config view -o jsonpath='{.current-context}' && echo"
alias kca="kubectl apply -f ." # Assuming this is what you meant
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
alias ds="docker system prune -af --volumes" # Added --volumes for more thorough cleanup, be careful
alias sshconfig="nvim ~/.ssh/config"
alias zshconfig="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"
alias nvimconfig="nvim ~/.config/nvim/init.lua" # or init.vim
alias tmuxconfig="nvim ~/.tmux.conf"
alias alacrittyconfig="nvim ~/.config/alacritty/alacritty.toml"
alias p10kconfig="p10k configure"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias dotfiles="cd ~/chriswk42/dotfiles" # Corrected path based on your gist structure

# --- Your Functions ---
# Function to create a directory and cd into it
mcd() {
  mkdir -p "$1" && cd "$1" || return
}

# Function to extract most common archive types
extract() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
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

# Function to quickly backup a file
bak() {
  cp "$1" "$1"_$(date +%Y%m%d%H%M%S).bak
}

# # Function for fzf to search git branches and checkout
# # Make sure fzf is installed and in PATH
# gb() {
#   local branches branch
#   branches=$(git branch --all | grep -v HEAD | sed "s/remotes\/origin\///g" | sed "s/remotes\///g" | sed "s/upstream\///g" | sed "s/^\s*//g" | sort -u)
#   branch=$(echo "$branches" | fzf-tmux -p --reverse)
#   if [[ -n "$branch" ]]; then
#     git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
#   fi
# }
#
# # Function to fzf search git log and show commit
# gl() {
#   local commit
#   commit=$(git log --oneline --decorate --graph --all | fzf-tmux -p --reverse --preview 'git show --color=always {+1}' | awk '{print $1}')
#   if [[ -n "$commit" ]]; then
#     git show "$commit"
#   fi
# }
