#!/bin/bash

FZF_DIR="${FZF_DIR:-"$HOME/.fzf"}"

[ -d "$FZF_DIR" ] && echo "FZF is already installed" && exit 0

[ -z "$(which git)" ] && echo "git is not installed" >&2 && exit 1

git clone https://github.com/junegunn/fzf.git "$FZF_DIR"
