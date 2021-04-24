# .zlogin
# This file is loaded only if the shell is a login shell:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
# -> /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zlogin.local" ]]; then
    . "$HOME/.zlogin.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zlogin" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zlogin"
fi


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zlogin_after.local" ]]; then
    . "$HOME/.zlogin_after.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zlogin_after" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zlogin_after"
fi
