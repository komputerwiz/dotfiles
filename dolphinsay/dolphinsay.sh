#!/usr/bin/env bash

COWSAY_ONLY_COWPATH=1 \
COWPATH="${XDG_CONFIG_HOME:-"$HOME/.config"}/dolphinsay/art" \
cowsay "$@"
