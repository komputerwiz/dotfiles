#!/bin/bash
set -e

for SCRIPT in "$HOME/_/docker/compose/"*"/update.sh"; do
  if test -x "$SCRIPT"; then
    echo "[docker]: $SCRIPT"
    # default behavior is to run script
    CONTINUE=y

    # presence of 'needs-confirm-update' file indicates that we should ask before updating
    if test -f "$(dirname "$SCRIPT")/needs-confirm-update"; then
      # overwrite value in CONTINUE variable
      read -p "Continue? [y/N]: " -n1 -r CONTINUE
      echo
    fi

    if [[ "$CONTINUE" =~ ^[Yy]$ ]]; then
      "$SCRIPT"
    fi
  else
    echo "[docker]: !! $SCRIPT is not executable: skipping"
  fi
done

docker system prune --volumes
