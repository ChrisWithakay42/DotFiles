eval "$(/opt/homebrew/bin/brew shellenv)"

##
# Your previous /Users/kris/.zprofile file was backed up as /Users/kris/.zprofile.macports-saved_2022-08-20_at_23:03:12
##

# MacPorts Installer addition on 2022-08-20_at_23:03:12: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-08-20_at_23:03:12: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.


# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH


# Added by Toolbox App
export PATH="$PATH:/Users/kris/Library/Application Support/JetBrains/Toolbox/scripts"


# Created by `pipx` on 2025-02-06 19:45:07
export PATH="$PATH:/Users/kris/.local/bin"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :


# Added by Antigravity CLI installer
export PATH="/Users/kris/.local/bin:$PATH"

# pyenv shims must come last: /etc/zprofile's path_helper and the Python.framework
# installer line above both prepend to PATH, demoting anything set in ~/.zshenv.
[[ -d "$HOME/.pyenv/shims" ]] && export PATH="$HOME/.pyenv/shims:$PATH"
