#!/bin/bash

set -e

INSTALL_DIR="$HOME/.dotfiles"
PKGFILE="$INSTALL_DIR/installed"

restow () {
  # restow installed packages after update (or error... yikes!)
  [ -f "$PKGFILE" ] && stow --dir="$INSTALL_DIR" --stow $(cat "$PKGFILE")
}

trap restow EXIT

if [ -f "$PKGFILE" ]; then
  BRANCH="$(git -C "$INSTALL_DIR" rev-parse --abbrev-ref HEAD)"

  # fetch changes, but don't update working directory yet
  git -C "$INSTALL_DIR" fetch

  # unstow all packages before merging in changes
  stow --dir="$INSTALL_DIR" --delete $(cat "$PKGFILE")

  git -C "$INSTALL_DIR" -c "user.name=Matthew Barry" -c "user.email=matthew@komputerwiz.net" rebase "origin/$BRANCH"
else
  # just pull and hope we don't create bad symlinks
  git -C "$INSTALL_DIR" pull
fi
