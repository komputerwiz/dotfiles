#!/bin/bash

# Sanity check: Verify that Vim is installed.
if [ -z `which vim` ]; then
    echo "Vim is not installed! Exiting."
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


echo "Creating symlink for vim config file ~/.vimrc."
[[ -f "${HOME}/.vimrc" ]] && mv "${HOME}/.vimrc" "${HOME}/.vimrc.local"
ln -s "${DIR}/vimrc" "${HOME}/.vimrc"


echo "Initializing bundles."
git clone $GITFLAGS https://github.com/gmarik/Vundle.vim "${DIR}/bundle/Vundle.vim"
vim +PluginInstall +qall


echo "Installation complete."
