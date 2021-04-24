#!/bin/sh

DIR="${0%/*}"
DIR="`cd "${DIR}" && pwd`"

cd "${DIR}"

echo "Updating bundle config..."
git pull
git submodule init
git submodule update

SAVEIFS=$IFS
IFS=$'\n'

for BUNDLE in $DIR/*.tmbundle; do
    if [[ -e "${BUNDLE}/.git" ]]; then
        echo "Checking for updates to ${BUNDLE##*/}"
        cd "${BUNDLE}"
        git checkout master
        git pull
    fi
done

IFS=$SAVEIFS

cd "${DIR}"

echo "Pushing changes back to central repository..."
git add .
git commit -m "[update.sh] updating submodules"
git push origin master

unset DIR
unset BUNDLE
unset SAVEIFS
