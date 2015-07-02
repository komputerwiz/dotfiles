#!/bin/bash

DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"

cd "${DIR}"

vim +PluginUpdate +qall

unset DIR
