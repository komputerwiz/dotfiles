#!/bin/bash

set -e

DIR="${RBENV_ROOT:-$HOME/.rbenv}"

if [ -n "$DIR" ] && [ -d "$DIR" ]; then
  echo "Updating rbenv"
  cd "$DIR"
  git pull

  RUBY_BUILD_DIR="$DIR/plugins/ruby-build"
  if [ -d "$RUBY_BUILD_DIR" ]; then
    echo "Updating rbenv ruby-build plugin"
    cd "$RUBY_BUILD_DIR"
    git pull
  fi
fi
