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

# Install komputerwiz OMZ theme and custom plugins
if [ -d "$OMZ" ]; then
    stow -t "$OMZ" -d "$DIR" "oh-my-zsh"
fi

echo "Installation complete."
