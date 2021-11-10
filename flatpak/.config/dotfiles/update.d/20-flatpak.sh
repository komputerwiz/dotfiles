#!/bin/bash
set -e

flatpak update
flatpak uninstall --unused
