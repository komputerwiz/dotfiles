#!/bin/bash
set -e

INSTALL_DIR="$HOME/.dotfiles"

cd "$INSTALL_DIR"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

git fetch
git -c "user.name=Matthew Barry" -c "user.email=matthew@komputerwiz.net" rebase "origin/$BRANCH"

"$INSTALL_DIR/.dotter/bin/dotter" deploy
