#!/bin/bash

nix profile list | grep '^Name' | awk '{gsub(/\x1b\[[0-9;]*m/, ""); print $2}' | xargs nix profile upgrade || true
