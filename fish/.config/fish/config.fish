alias t='todo.sh'
alias v="$EDITOR"

alias la='ls -aF'
alias ll='ls -hlF'
alias lal='ls -ahlF'
alias lla='ls -ahlF'
alias l='ls -F'

alias cp='cp -i'
alias mv='mv -i'

alias h='history'
alias hs='history | grep'

function dr --wraps docker --description 'run ephemeral docker container in current directory'
  docker run --interactive --tty --rm --volume "$PWD:/data:rw" --workdir /data $argv
end
