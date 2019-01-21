#!/bin/bash

set -e

[ -z "$(which git)" ] && echo "git is not installed!" >&2 && exit 1

FZF_DIR="$HOME/.fzf"

[ ! -d "$FZF_DIR" ] && echo "FZF is not installed!" >&2 && exit 1

git -C "$FZF_DIR" pull
"$FZF_DIR/install"
