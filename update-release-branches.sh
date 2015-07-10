#!/bin/bash

# ensure we do not have any remote tracking branches
if [[ -n "$(git branch | grep host)" ]]; then
    echo "you have a 'host/' branch checked out. aborting." >&2
    exit 1
fi

for host_branch in $(git branch -a | grep host | sed -E -e 's/^.*(host\/[-A-Za-z_\.]+)$/\1/'); do
    echo -n $host_branch
    git checkout $host_branch > /dev/null 2>&1
    echo -n "."
    git rebase master > /dev/null 2>&1
    echo -n "."
    git push -f > /dev/null 2>&1
    echo -n "."
    git checkout master > /dev/null 2>&1
    echo -n "."
    git branch -d $host_branch > /dev/null 2>&1
    echo "."
done
