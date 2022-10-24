#!/bin/bash
set -e

if test -w "$(npm root -g)"; then
  npm update -g
else
  sudo npm update -g
fi
