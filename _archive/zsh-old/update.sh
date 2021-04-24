#!/bin/sh

DIR="${0%/*}"
DIR="`cd "$DIR" && pwd`"

cd "$DIR"

echo "Updating zsh config..."
git fetch --quiet
git merge --quiet origin/master
echo "Pushing changes back to central repository..."
git push --quiet origin master

unset DIR
