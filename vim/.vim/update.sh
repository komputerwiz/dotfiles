#!/bin/bash

DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"

cd "${DIR}"

vim +PluginClean +PluginInstall +PluginUpdate +qall

unset DIR
