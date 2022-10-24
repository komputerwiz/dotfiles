# .zprofile
# This file is loaded only if the shell is a login shell:
#    /etc/zshenv    +  ~/.zshenv
# -> /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### LOAD ADDITIONAL LOCAL FILES ###

for file in "$HOME"/.zsh/profile.d/*.zsh(N); do source "$file"; done
