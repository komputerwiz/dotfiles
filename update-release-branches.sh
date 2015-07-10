#!/bin/bash

# ensure we do not have any remote tracking branches
if [[ -n "$(git branch | grep host)" ]]; then
    echo "you have a 'host/' branch checked out. aborting." >&2
    exit 1
fi

# ensure we have the latest version of the repository
# DON'T STEP ON ANYONE ELSE'S CHANGES
git fetch --prune

for host_branch in $(git branch -a | grep host | sed -E -e 's/^.*(host\/[-A-Za-z_\.]+)$/\1/'); do
    echo -n $host_branch

    # check out remote tracking branch
    git checkout $host_branch > /dev/null 2>&1
    echo -n "."

    # rebase branch onto master:
    #   - incorporates new commits from master
    #   - reapplies local changes
    git rebase master > /dev/null 2>&1
    echo -n "."

    # send back to remote (have to force-push)
    git push -f origin $host_branch > /dev/null 2>&1
    echo -n "."

    # switch back to master...
    git checkout master > /dev/null 2>&1
    echo -n "."

    # ...so we can delete the branch we were on
    git branch -d $host_branch > /dev/null 2>&1
    echo "."
done
