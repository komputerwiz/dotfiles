#!/bin/bash

DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"

cd "${DIR}"

echo "Updating vim config..."
git pull --quiet origin master
vim +PluginUpdate +qall

if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
	echo "Vim config dir has changed. You should probably commit and push changes."
	# git commit -am "[update.sh] updating submodules"
	# git push origin master
fi

unset DIR
