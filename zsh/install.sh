#!/bin/bash

[ -z "$(which zsh)" ] && echo "ZSH is not installed! Exiting." >&2 && exit 1
[ -z "$(which git)" ] && echo "Git is not installed! Exiting." >&2 && exit 1

# Default options
GITFLAGS="--quiet"

# Parse command-line options
while getopts ":s" opt; do
    case $opt in
        s) GITFLAGS="${GITFLAGS} --depth 1" ;;
        *) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done

echo "Installing Antigen..."
git clone $GITFLAGS https://github.com/zsh-users/antigen.git "$HOME/.zsh/antigen"

echo "Installation complete. Restart your shell to initialize the awesome!"
