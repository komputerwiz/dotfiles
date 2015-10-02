# .zshenv
# This file is loaded unconditionally:
# -> /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### ENVIRONMENT VARIABLES AND OPTIONS ###

# my files are not writable
umask 022

# other environment variables
export EDITOR="vim"


### GLOBAL PATHS ###

if [[ -d $HOME/.local/bin ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

export PATH="$PATH:."
