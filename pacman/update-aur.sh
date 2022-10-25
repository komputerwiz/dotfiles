#!/bin/bash
set -e
shopt -s extglob nullglob

for REPO in "${AUR_HOME:-"$HOME/aur"}/"!(_archive)/; do
  pushd "$REPO" > /dev/null
  echo -e "\e[33m>>> [AUR] $(basename "$REPO")\e[0m" >&2
  git fetch
  CURRENT_HEAD="$(git rev-parse HEAD)"
  UPSTREAM_HEAD="$(git rev-parse @{upstream} 2> /dev/null || echo "")"
  if [ -n "$UPSTREAM_HEAD" -a "$CURRENT_HEAD" != "$UPSTREAM_HEAD" ]; then
    git pull
    makepkg -scir
  else
    echo "Nothing to update."
  fi
  popd > /dev/null
done
