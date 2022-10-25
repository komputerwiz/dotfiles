function dr --wraps docker --description 'run ephemeral docker container in current directory'
  docker run --interactive --tty --rm --volume "$PWD:/data:rw" --workdir /data $argv
end
