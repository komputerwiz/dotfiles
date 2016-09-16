# .zlogin
# This file is loaded only if the shell is a login shell:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
# -> /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout

### ANTIGEN ###

source "$HOME/.antigen/antigen.zsh"


### FRAMEWORK CONFIG ###

DISABLE_CORRECTION="true"


### OH-MY-ZSH FRAMEWORK AND PLUGINS ###

antigen use oh-my-zsh

antigen bundle git
#antigen bundle git-flow
antigen bundle history
#antigen bundle rbenv
#antigen bundle sublime
antigen bundle sudo
#antigen bundle symfony2
#antigen bundle tmux
#antigen bundle vi-mode
antigen bundle wd

antigen bundle "$HOME/.zsh/plugins/reboot-notifier"

# autosuggestions must be loaded before syntax highlighting
antigen bundle tarruda/zsh-autosuggestions

antigen bundle zsh-users/zsh-syntax-highlighting

# history substring search must be loaded after syntax highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen theme "$HOME/.zsh/themes" komputerwiz


### OPTIONS ###

setopt no_nomatch       # don't bug me about filename expansion
setopt no_hist_verify   # immediately execute history line
setopt no_list_beep     # do not beep for autocomplete
setopt dvorak           # oh yeah!
setopt extended_glob    # extra goodies for file globbing (like *~*.js)


### KEY BINDINGS ###

zmodload zsh/terminfo

# common terminal keybindings
bindkey "$terminfo[khome]" beginning-of-line
bindkey "$terminfo[kend]" end-of-line
bindkey "$terminfo[kdch1]" delete-char-or-list


# fix issue with vi-mode and history-substring-search
# see https://github.com/robbyrussell/oh-my-zsh/issues/2735

# bind k and j for VI mode
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

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

alias t='todo.sh'

# list files
alias la='ls -a'
alias ll='ls -hl'
alias lal='ls -ahl'
alias lla='ls -ahl'
alias l='ls -F'

# ask for confirmation on copy, move, and delete
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# git shorthand
alias gci='git commit'
alias gdt='git difftool'
alias gf='git fetch'
alias glg='git log --pretty=oneline-detailed --graph --all --decorate --date=local --author-date-order'

# SHA1 hashing
alias sha1='openssl sha1'

# canonical mode for viewing binary files
alias hexdump='hexdump -C'
alias od='od -Ax -tx1'

# regular expressions in grep and sed
# alias grep='grep -E'
# alias sed='sed -E'


### FUNCTIONS ###

# aggressive garbage collection on a git repo
git-gc-aggressive () {
    rm -rf .git/refs/original/*
    git reflog expire --all --expire-unreachable=0
    git repack -A -d
    git prune
}

# system-independent way of copying stdin to the clipboard
__copy_to_clipboard() {
    if [ "$(uname)" == "Darwin" ]; then
        pbcopy
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        xclip -selection CLIPBOARD
    else
        cat
    fi
}

# perform a hash of the string in the given argument and copy it to the clipboard
copy_hash() {
    echo -n "$2" | openssl dgst "-$1" | cut -d ' ' -f 2 | awk '{printf("%s",$0);}' | __copy_to_clipboard
}

### AUTOSUGGESTIONS CONFIG ###

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
