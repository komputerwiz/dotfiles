#!/bin/bash
set -e

sudo flatpak update --assumeyes
sudo flatpak uninstall --unused --assumeyes
