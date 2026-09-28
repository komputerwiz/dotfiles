#!/bin/bash
set -e

brew update
brew upgrade{{#if homebrew_greedy_updates}} --greedy-auto-updates{{/if}}

brew autoremove
brew cleanup
