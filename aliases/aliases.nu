# system {{{

alias ll = ls -l
alias la = ls -a
alias lal = ls -al
alias lla = ls -al

# }}}
# git {{{

alias g = git
alias ga = git add
alias gaa = git add --all
alias gb = git branch
alias gbd = git branch --delete
alias gbl = git blame -b -w -C -C -C
alias gbs = git bisect
alias gbsb = git bisect bad
alias gbsg = git bisect good
alias gbsr = git bisect reset
alias gbss = git bisect start
alias gc = git commit -v
alias gca = git commit -v --amend
alias gcan = git commit -v --amend --no-edit
alias gcp = git cherry-pick
alias gcpa = git cherry-pick --abort
alias gcpc = git cherry-pick --continue
alias gd = git diff
alias gdca = git diff --cached
alias gdt = git difftool
alias gf = git fetch
alias gfa = git fetch --all --prune --jobs=10
alias gg = git log --pretty=oneline-detailed --graph --all --decorate --date=iso
alias gl = git pull
alias gls = git log --stat
alias glsp = git log --stat -p
alias gm = git merge
alias gma = git merge --abort
alias gmc = git merge --continue
alias gp = git push
alias gpf = git push --force-with-lease
alias grb = git rebase
alias grba = git rebase --abort
alias grbc = git rebase --continue
alias grbi = git rebase --interactive
alias grbs = git rebase --skip
alias grm = git rm
alias grmc = git rm --cached
alias grs = git restore --staged
alias gst = git status
alias gsta = git stash push
alias gstd = git stash drop
alias gstl = git stash list
alias gstp = git stash pop
alias gsts = git stash show --text
alias gsw = git switch
alias gswc = git switch --create
alias gy = git apply
alias gyr = git apply --reverse

# }}}

# vim: foldmethod=marker
