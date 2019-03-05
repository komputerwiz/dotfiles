#!/bin/bash

set -e

if [ -n "$RBENV_ROOT" ] && [ -d "$RBENV_ROOT" ]; then
  echo "Updating rbenv"
  cd "$RBENV_ROOT"
  git pull

  RUBY_BUILD_DIR="$RBENV_ROOT/plugins/ruby-build"
  if [ -d "$RUBY_BUILD_DIR" ]; then
    echo "Updating rbenv ruby-build plugin"
    cd "$RUBY_BUILD_DIR"
    git pull
  fi
fi
