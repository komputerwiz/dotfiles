#!/bin/bash

[ -z "$(which zsh)" ] && echo "ZSH is not installed! Exiting." >&2 && exit 1

echo "Installing Antigen..."
curl -L https://git.io/antigen > "$HOME/.zsh/antigen.zsh"

echo "Installation complete. Restart your shell to initialize the awesome!"
