#!/bin/bash

[ -z "$(which git)" ] && echo "git is not installed" >&2 && exit 1

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
