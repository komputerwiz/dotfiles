#!/bin/bash

# Sanity check: Verify that Zsh is installed.
if [ -z `which zsh` ]; then
    echo "Zsh is not installed! Exiting."
    exit 1
fi

OMZ="$HOME/.oh-my-zsh"

# Sanity check: Verify that Oh My Zsh is installed
if [ ! -d "$OMZ" ]; then
    echo "Oh My Zsh is not installed. Would you like to install it?"
    echo "Type Y to install: "
    read line
    if [ "$line" = Y ] || [ "$line" = y ]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git "$OMZ"
    fi
fi

# Sanity check: Verify that Zsh is set as the default shell
if [[ "$SHELL" != *zsh* ]]; then
    echo "Zsh is not set as your shell (currently $SHELL). Should I change it?"
    echo "Type Y to change to Zsh: "
    read line
    if [ "$line" = Y ] || [ "$line" = y ]; then
        chsh -s `which zsh`
    fi
fi

DIR="${0%/*}"
DIR="`cd "$DIR" && pwd`"

# Create symlinks for all Zsh config files
for ZFILE in zlogin zlogout zprofile zshenv zshrc; do
    [[ -f "$HOME/.$ZFILE" ]] && mv "$HOME/.$ZFILE" "$HOME/.$ZFILE.local"
    ln -s "$DIR/$ZFILE" "$HOME/.$ZFILE"
done

# Allow for "localized" host config files
if [[ -n "$1" ]] && [[ -d "$DIR/host/$1" ]]; then
    HOSTFILES="$DIR/host/$1/*"
    shopt -s nullglob
    for ZFILE in $HOSTFILES; do
        ln -s "$ZFILE" "$HOME/.${ZFILE##*/}.local"
    done
fi

# Install komputerwiz OMZ theme
if [ -d "$OMZ" ]; then

    LINK_FILES=(
        themes/komputerwiz.zsh-theme
        plugins/reboot-notifier
        plugins/symfony3
    )

    for LINK_FILE in "${LINK_FILES[@]}"; do
        if [ -e "${OMZ}/${LINK_FILE}" ]; then
            mv "${OMZ}/${LINK_FILE}" "$OMZ/${LINK_FILE}.orig"
        fi
        ln -s "${DIR}/oh-my-zsh/${LINK_FILE}" "${OMZ}/${LINK_FILE}"
    done

fi

echo "Installation complete."
