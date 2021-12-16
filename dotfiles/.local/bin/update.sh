#!/bin/bash
set -e

DRY=false

print_help () {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "  Options:"
  echo "    -a DAYS  Automatic mode: only update if not run in the given number of DAYS."
  echo "    -n       Dry-run; don't actually execute scripts; just show what would be run."
  echo "    -h       Display this help message."
}

while getopts ":a:hn" opt; do
  case "$opt" in
    a)
      FREQ="$OPTARG"
      RE_NUMBER='^[0-9]+$'
      if ! [[ "$FREQ" =~ $RE_NUMBER ]]; then
        echo "Argument -a expected number, received '$FREQ'" >&2
        exit 1
      fi
      ;;
    n) DRY=true ;;
    h)
      print_help
      exit 0
      ;;
    ?)
      print_help
      exit 1
      ;;
  esac
done

DATA_DIR="${XDG_DATA_HOME:-"$HOME/.local/share"}/dotfiles"
if test ! -d "$DATA_DIR"; then
  mkdir -p "$DATA_DIR"
fi

# prevent multiple instances from runinng simultaneously
LOCKFILE="$DATA_DIR/update.lock"
if test -f "$LOCKFILE"; then
  echo "update script already running" >&2
  exit 1
fi

touch "$LOCKFILE"
unlock () { rm -f "$LOCKFILE"; }
trap unlock EXIT

# attempt to load last update date from file
EPOCH_FILE="$DATA_DIR/update_epoch"
if test -f "$EPOCH_FILE"; then
  LAST_RUN="$(cat "$EPOCH_FILE")"
fi

NOW=$(( $(date +%s) / 60 / 60 / 24 ))
if test -n "$LAST_RUN" -a -n "$FREQ"; then
  if test "$(expr "$NOW" - "$LAST_RUN" )" -lt "$FREQ"; then
    echo "update was run recently; exiting"
    exit 0
  fi
fi

CONF_DIR="${XDG_CONFIG_HOME:-"$HOME/.config"}/dotfiles"
for SCRIPT in "$CONF_DIR"/update.d/*; do
  if test -x "$SCRIPT"; then
    echo ">>> $SCRIPT"
    if test "$DRY" != true; then
      "$SCRIPT"
    fi
  else
    echo "!!! $SCRIPT is not executable: skipping"
  fi
done

# save epoch to file
echo "$NOW" > "$EPOCH_FILE"
