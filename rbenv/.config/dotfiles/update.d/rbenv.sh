#!/bin/bash

if [ -n "$RBENV_ROOT" ]; then
  RUBY_BUILD_DIR="$RBENV_ROOT/plugins/ruby-build"

  if [ -d "$RUBY_BUILD_DIR" ]; then
    echo "Updating rbenv ruby-build plugin"
    cd "$RUBY_BUILD_DIR"
    git pull
  fi
fi
