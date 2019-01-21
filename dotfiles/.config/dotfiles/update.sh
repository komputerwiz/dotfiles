#!/bin/bash

FREQ=3 # days

# attempt to load last update date from file
EPOCH_FILE="${XDG_DATA_HOME:-"$HOME/.local/share"}/dotfiles/update_epoch"
[ -f "$EPOCH_FILE" ] && LAST_RUN="$(cat "$EPOCH_FILE")"

NOW=$(( $(date +%s) / 60 / 60 / 24 ))
[ ! -z "$LAST_RUN" ] && [ "$(( $NOW - $LAST_RUN ))" -lt "$FREQ" ] && exit 0

DIR="$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null && pwd)"
for SCRIPT in "$DIR"/update.d/*; do
  if [ -x "$SCRIPT" ]; then
    echo ">>> $SCRIPT"
    "$SCRIPT"
  else
    echo "!!! $SCRIPT is not executable: skipping"
  fi
done

# save epoch to file
[ ! -d "$(dirname "$EPOCH_FILE")" ] && mkdir -p "$(dirname "$EPOCH_FILE")"
echo "$NOW" > "$EPOCH_FILE"

sleep 3
