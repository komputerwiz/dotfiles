#!/bin/bash
set -e

brew update
brew upgrade

brew autoremove
brew cleanup
