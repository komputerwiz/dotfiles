dr() {
  docker run --interactive --tty --rm --volume "$PWD:/data:rw" --workdir /data "$@"
}
