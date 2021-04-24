# .zprofile
# This file is loaded only if the shell is a login shell:
#    /etc/zshenv    +  ~/.zshenv
# -> /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zprofile.local" ]]; then
    . "$HOME/.zprofile.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zprofile" ]]; then
    . "$HOME/.zsh/host/${HOST%.*}/zprofile"
fi


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zprofile_after.local" ]]; then
    . "$HOME/.zprofile_after.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zprofile_after" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zprofile_after"
fi
