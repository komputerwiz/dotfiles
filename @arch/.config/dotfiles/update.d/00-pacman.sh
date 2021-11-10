#!/bin/bash
set -e

sudo pacman -Syu || true

ORPHANS=$(pacman -Qtdq)
if test -n "$ORPHANS"; then
  sudo pacman -Rns $ORPHANS
fi
