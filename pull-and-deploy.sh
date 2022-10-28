#!/bin/bash
set -e

if [[ "$OSTYPE" == darwin* ]]; then
  OS=darwin
elif [[ "$OSTYPE" = linux-gnu* ]]; then
  OS=linux
fi

ARCH="$HOSTTYPE"

INSTALL_DIR="$HOME/.dotfiles"
DOTTER="$INSTALL_DIR/.dotter/bin/dotter-$OS-$ARCH"

if test ! -x "$DOTTER"; then
  echo "dotter exec not found for OS ($OS) and arch ($ARCH)" >&2
  exit
fi

cd "$INSTALL_DIR"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

git fetch
git -c "user.name=Matthew Barry" -c "user.email=matthew@komputerwiz.net" rebase "origin/$BRANCH"

"$DOTTER" deploy
