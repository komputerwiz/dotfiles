# .zshenv
# This file is loaded unconditionally:
# -> /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zshenv.local" ]]; then
    . "$HOME/.zshenv.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zshenv" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zshenv"
fi


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

### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zshenv_after.local" ]]; then
    . "$HOME/.zshenv_after.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zshenv_after" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zshenv_after"
fi
