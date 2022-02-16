#!/bin/bash
set -e

sudo pacman -Syu

ORPHANS=$(pacman -Qtdq || true)
if test -n "$ORPHANS"; then
  sudo pacman -Rns $ORPHANS
fi
