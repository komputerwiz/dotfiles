#!/bin/bash
set -e

if test "$#" -eq 0; then
  echo "Usage: $0 HOST..." >&2
  echo >&2
  echo "Available hosts:" >&2
  git branch -a | grep host | sed 's/.*\//  - /'
  exit 1
fi

for HOST in "$@"; do
  BRANCH="host/$HOST"

  echo -n "$HOST "
  git checkout --quiet "$BRANCH"
  echo -n "."
  git pull --quiet
  echo -n "."
  git rebase --quiet master
  echo -n "."
  git push --quiet --force
  echo -n "."
  git checkout --quiet master
  echo -n "."
  git branch --quiet --delete --force "$BRANCH"
  echo " done!"
done
