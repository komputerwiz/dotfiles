# .zlogout
# This file is run when a shell is logging out:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
#    /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
# -> /etc/zlogout   +  ~/.zlogout


### UPDATE SCRIPT DEFINITION ###

update_scripts=("$HOME/.vim/update.sh")


### AUTOMATIC UPDATES ###

LOCKFILE="$HOME/.zsh/var/update_epoch.lock"

function _current_epoch() {
    echo $(($(date +%s) / 60 / 60 / 24))
}

function _update_update_lock() {
    [[ ! -d "$(dirname "$LOCKFILE")" ]] && mkdir -p $(dirname "$LOCKFILE")
    echo "LAST_EPOCH=$(_current_epoch)" > "$LOCKFILE"
}

if [ -f "$LOCKFILE" ]; then
    . "$LOCKFILE"

    if [[ -z "${LAST_EPOCH}" ]]; then
        _update_update_lock && return 0
    fi

    days_since_update=$(($(_current_epoch) - $LAST_EPOCH))
    if [ $days_since_update -gt 2 ]; then
        for script in "${update_scripts[@]}"; do
            echo ">>> ${script}"
            [[ -x "$script" ]] && "${script}"
        done
        _update_update_lock
        sleep 3
    fi
else
    _update_update_lock
fi


### CLEAR SCREEN ###

clear

unset LOCKFILE
