#!/bin/bash

# Sanity check: Verify that Vim is installed.
if [ -z `which zsh` ]; then
    echo "ZSH is not installed! Exiting."
    exit 1
fi

if [ -z `which git` ]; then
    echo "Git is not installed! Exiting."
    exit 1
fi


# Default options
GITFLAGS="--quiet"

# Parse command-line options
while getopts ":s" opt; do
    case $opt in
        s) GITFLAGS="${GITFLAGS} --depth 1" ;;
        *) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done


DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"
cd "${DIR}"


echo "Installing Antigen..."
git clone $GITFLAGS https://github.com/gmarik/Vundle.vim "$HOME/.antigen"


echo "Installation complete. Restart your shell to initialize the awesome!"
