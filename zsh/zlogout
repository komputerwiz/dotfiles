# .zlogout
# This file is run when a shell is logging out:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
# -> /etc/zlogout   +  ~/.zlogout


### AUTOMATIC UPDATES ###

[ -x "$HOME/.config/dotfiles/update.sh" ] && "$HOME/.config/dotfiles/update.sh"


### LOAD ADDITIONAL LOCAL FILES ###

for file in "$HOME"/.zsh/logout.d/*.zsh(N); do source "$file"; done


### CLEAR SCREEN ###

clear
