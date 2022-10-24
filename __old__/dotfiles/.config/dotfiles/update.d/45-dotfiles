#!/bin/bash

set -e

INSTALL_DIR="$HOME/.dotfiles"
PKGFILE="$INSTALL_DIR/installed"

PWD_SAVE="$PWD"

restow () {
  cd "$INSTALL_DIR"
  # restow installed packages after update (or error... yikes!)
  [ -f "$PKGFILE" ] && stow --stow $(cat "$PKGFILE")
  cd "$PWD_SAVE"
}

trap restow EXIT

cd "$INSTALL_DIR"
if [ -f "$PKGFILE" ]; then
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"

  # fetch changes, but don't update working directory yet
  git fetch

  # unstow all packages before merging in changes
  stow --delete $(cat "$PKGFILE")

  git -c "user.name=Matthew Barry" -c "user.email=matthew@komputerwiz.net" rebase "origin/$BRANCH"
else
  # just pull and hope we don't create bad symlinks
  git pull
fi

cd "$PWD_SAVE"
