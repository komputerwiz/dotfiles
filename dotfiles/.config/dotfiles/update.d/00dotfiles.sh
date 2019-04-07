#!/bin/bash

set -e

INSTALL_DIR="$HOME/.dotfiles"
PKGFILE="$INSTALL_DIR/installed"

if [ -f "$PKGFILE" ]; then
  BRANCH="$(git -C "$INSTALL_DIR" rev-parse --abbrev-ref HEAD)"

  # fetch changes, but don't update working directory yet
  git -C "$INSTALL_DIR" fetch

  # unstow all packages before merging in changes
  stow --dir="$INSTALL_DIR" --delete $(cat "$PKGFILE")

  git -C "$INSTALL_DIR" rebase "origin/$BRANCH"

  # restow packages
  stow --dir="$INSTALL_DIR" --stow $(cat "$PKGFILE")
else
  # just pull and hope we don't create bad symlinks
  git -C "$INSTALL_DIR" pull
fi
