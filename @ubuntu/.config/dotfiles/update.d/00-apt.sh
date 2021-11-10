#!/bin/bash
set -e

sudo apt update
sudo apt full-upgrade

sudo apt autoremove --purge
