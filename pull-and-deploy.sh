#!/bin/bash
set -e

INSTALL_DIR="$HOME/.dotfiles"
DOTTER="$INSTALL_DIR/dotter"

BRANCH="$(git -C "$INSTALL_DIR" rev-parse --abbrev-ref HEAD)"

git -C "$INSTALL_DIR" fetch
git -C "$INSTALL_DIR" -c "user.name=Matthew Barry" -c "user.email=matthew@komputerwiz.net" rebase "origin/$BRANCH"

"$DOTTER" deploy
