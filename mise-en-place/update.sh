#!/bin/bash
set -e

# self-update (fails if installed via package manager)
mise self-update || true

# ensure most recent tools are installed
mise upgrade

# remove unused tools
mise prune
