#!/bin/bash

DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"

cd "${DIR}"

vim +PlugClean +PluginInstall +PlugUpdate +qall

unset DIR
