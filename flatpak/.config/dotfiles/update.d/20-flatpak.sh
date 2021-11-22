#!/bin/bash
set -e

flatpak update --assumeyes
flatpak uninstall --unused --assumeyes
