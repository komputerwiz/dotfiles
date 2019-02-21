#!/bin/bash
set -e

FREQ=3 # days
DATA_DIR="${XDG_DATA_HOME:-"$HOME/.local/share"}/dotfiles"
[ -d "$DATA_DIR" ] || mkdir -p "$DATA_DIR"

# prevent multiple instances from runinng simultaneously
LOCKFILE="$DATA_DIR/update.lock"
[ -f "$LOCKFILE" ] && echo "update script already running" >&2 && exit 1
touch "$LOCKFILE"
unlock () { rm -f "$LOCKFILE"; }
trap unlock EXIT

# attempt to load last update date from file
EPOCH_FILE="$DATA_DIR/update_epoch"
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
echo "$NOW" > "$EPOCH_FILE"

sleep 3
