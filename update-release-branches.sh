#!/bin/bash

# ensure we do not have any remote tracking branches
if [[ -n "$(git branch | grep host)" ]]; then
    echo "you have a 'host/' branch checked out. aborting." >&2
    exit 1
fi

# ensure we have the latest version of the repository
# DON'T STEP ON ANYONE ELSE'S CHANGES
git fetch --prune

# ensure host/_skel has the most up-to-date changes from master
echo -n "host/_skel: "

git checkout host/_skel > /dev/null 2>&1
if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
echo -n "C"

git rebase master > /dev/null 2>&1
if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
echo -n "R"

# send back to remote (have to force-push)
git push -f origin host/_skel > /dev/null 2>&1
if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
echo "P"

for host_branch in $(git branch -a | grep host | grep -v _skel | sed -E -e 's/^.*(host\/[-A-Za-z_\.]+)$/\1/'); do
    echo -n "$host_branch: "

    # check out remote tracking branch
    git checkout $host_branch > /dev/null 2>&1
    if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
    echo -n "C"

    # rebase branch onto host/_skel:
    #   - incorporates new commits from master and host/_skel
    #   - reapplies local changes
    git rebase host/_skel > /dev/null 2>&1
    if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
    echo -n "R"

    # send back to remote (have to force-push)
    git push -f origin $host_branch > /dev/null 2>&1
    if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
    echo -n "P"

    # switch back to host/_skel...
    git checkout host/_skel > /dev/null 2>&1
    if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
    echo -n "B"

    # ...so we can delete the branch we were on
    git branch -d $host_branch > /dev/null 2>&1
    if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
    echo "D"
done

echo "host/_skel: "

# switch to master...
git checkout master > /dev/null 2>&1
if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
echo -n "B"

# ...so we can delete the host/_skel branch
git branch -d host/_skel > /dev/null 2>&1
if  [[ $? != 0 ]]; then echo -e "\e[1;31mE\e[0m"; exit 1; fi
echo "D"
