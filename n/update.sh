#!/bin/bash
set -e

# self-update
n-update -y

# user-defined versions
VERSIONS_FILE="${XDG_CONFIG_HOME:-"$HOME/.config"}/n/versions"
if test -f "$VERSIONS_FILE"; then
	grep -v '^[[:space:]]*\(#\|$\)' "$VERSIONS_FILE" | while read VERSION; do
		n "$VERSION"
	done
fi

# ensure most recent `lts` and `latest` are installed; leave `latest` as active
n lts
n latest
