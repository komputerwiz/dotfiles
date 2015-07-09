# .zshrc
# This file is loaded only if the shell is interactive:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
# -> /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### OH-MY-ZSH ###

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded. (default 'robbyrussell')
ZSH_THEME="komputerwiz"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Don't prompt for update check
DISABLE_UPDATE_PROMPT="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    extract
    git
    history
    history-substring-search
    # npm
    reboot-notifier
    # screen
    sudo
    symfony2
    # symfony3
    tmux
    vi-mode
    wd
)


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zshrc.local" ]]; then
    . "$HOME/.zshrc.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zshrc" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zshrc"
fi


### LOAD OH-MY-ZSH ###

source $ZSH/oh-my-zsh.sh


### OPTIONS ###

setopt no_nomatch       # don't bug me about filename expansion
setopt no_hist_verify   # immediately execute history line
setopt no_list_beep     # do not beep for autocomplete
setopt dvorak           # oh yeah!

zmodload zsh/terminfo

# common terminal keybindings
bindkey "$terminfo[khome]" beginning-of-line
bindkey "$terminfo[kend]" end-of-line
bindkey "$terminfo[kdch1]" delete-char-or-list


# fix issue with vi-mode and history-substring-search
# see https://github.com/robbyrussell/oh-my-zsh/issues/2735

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# fix issue with esc key binding for sudo plugin
bindkey -M vicmd "\e" sudo-command-line

# bind UP and DOWN arrow keys
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
bindkey "$terminfo[cuu]" history-substring-search-up
bindkey "$terminfo[cud]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### ALIASES ###

# list files
alias la='ls -a'
alias ll='ls -hl'
alias lal='ls -ahl'
alias lla='ls -ahl'
alias l='ls -F'

# ask to overwrite files on copy
alias cp='cp -i'

# git shorthand
alias gci='git commit'
alias gdt='git difftool'
alias gf='git fetch'
alias glg='git log --oneline --graph --all --decorate'

# SHA1 hashing
alias sha1='openssl sha1'

# canonical mode for viewing binary files
alias hexdump='hexdump -C'
alias od='od -Ax -tx1'

# regular expressions in grep and sed
# alias grep='grep -E'
# alias sed='sed -E'


### FUNCTIONS ###

# eavesdrop on your system (http://commandlinefu.com/commands/view/5068/eavesdrop-on-your-system
whatsup () diff <(lsof -p $1) <(sleep ${2:-10}; lsof -p $1)

# automatically LS after CD
cdls () { cd "$@" && ls; }

# aggressive garbage collection on a git repo
git-gc-aggressive () {
    rm -rf .git/refs/original/*
    git reflog expire --all --expire-unreachable=0
    git repack -A -d
    git prune
}


### SYSTEM-SPECIFIC OVERRIDE SETTINGS ###

if [[ -s "$HOME/.zshrc_after.local" ]]; then
    . "$HOME/.zshrc_after.local"
elif [[ -s "$HOME/.zsh/host/${HOST%%.*}/zshrc_after" ]]; then
    . "$HOME/.zsh/host/${HOST%%.*}/zshrc_after"
fi
