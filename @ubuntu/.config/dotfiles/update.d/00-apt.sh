#!/bin/bash
set -e

sudo apt update
sudo apt full-upgrade --assume-yes

sudo apt autoremove --purge --assume-yes
