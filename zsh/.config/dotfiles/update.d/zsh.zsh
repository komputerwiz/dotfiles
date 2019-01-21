#!/bin/zsh

source "$ADOTDIR/antigen.zsh"
antigen init "$HOME/.zsh/antigenrc"

antigen cleanup
antigen selfupdate
antigen update
