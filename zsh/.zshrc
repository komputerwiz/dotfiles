# .zshrc
# This file is loaded only if the shell is an interactive shell:
#    /etc/zshenv    +  ~/.zshenv
#    /etc/zprofile  +  ~/.zprofile
# -> /etc/zshrc     +  ~/.zshrc
#    /etc/zlogin    +  ~/.zlogin
#    ...
#    /etc/zlogout   +  ~/.zlogout


### ANTIGEN ###

source "$ADOTDIR/antigen.zsh"
antigen init "$HOME/.zsh/antigenrc"


### OPTIONS ###

# don't bug me about filename expansion
setopt no_nomatch
# immediately execute history line
setopt no_hist_verify
# do not beep for autocomplete
setopt no_list_beep
# oh yeah!
setopt dvorak
# extra goodies for file globbing (like *~*.js)
setopt extended_glob


### KEY BINDINGS ###

zmodload zsh/terminfo

# common terminal keybindings
bindkey "$terminfo[khome]" beginning-of-line
bindkey "$terminfo[kend]" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
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
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

# autosuggest
bindkey '^ ' autosuggest-accept


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
alias gdt='git difftool'
alias glg='git log --pretty=oneline-detailed --graph --all --decorate --date=iso'
alias gls='git log --stat'
alias glsp='git log --stat -p'

# canonical mode for viewing binary files
alias hexdump='hexdump -C'
alias od='od -Ax -tx1'


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
        if [ -z "$(which xsel)" ]; then
          xsel -b
        elif [ -z "$(which xclip)" ]; then
          xclip -selection CLIPBOARD
        else
          echo "Unable to copy to clipboard: xsel nor xclip is installed." >&2
          cat
        fi
    else
        cat
    fi
}

# perform a hash of the string in the given argument and copy it to the clipboard
copy_hash() {
    echo -n "$2" | openssl dgst "-$1" | cut -d ' ' -f 2 | awk '{printf("%s",$0);}' | __copy_to_clipboard
}

# Perform a given command in each git repository in the current directory.
each_repo() {
    ROOT_PWD="$(pwd)"
    for REPO in $(ls); do
        # skip if not a directory or a git repository
        if [[ ! ( -d "$REPO"  && -d "$REPO/.git" ) ]]; then
            continue
        fi
        cd "$REPO"
        echo "\n$REPO"
        if eval "$@"; then
            # command succeeded
        else
            echo -e "\e31mfailure to execute in $REPO"
        fi
        cd "$ROOT_PWD"
    done
}


### AUTOSUGGESTIONS CONFIG ###

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)


### LOAD ADDITIONAL LOCAL FILES ###

for file in "$HOME"/.zsh/rc.d/*.zsh(N); do source "$file"; done
