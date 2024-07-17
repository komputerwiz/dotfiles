#!/bin/zsh

source "$HOME/.zsh/antigen.zsh"
antigen init "$HOME/.zsh/antigenrc"

antigen cleanup
antigen selfupdate
antigen update
