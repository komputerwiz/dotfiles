#!/bin/bash
set -e

FZF_DIR="${FZF_DIR:-"$HOME/.fzf"}"

git -C "$FZF_DIR" pull
"$FZF_DIR/install --bin"
