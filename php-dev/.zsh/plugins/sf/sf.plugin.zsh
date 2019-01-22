sf () {
  if [ -f bin/console ]; then
    php bin/console $@
  fi
}
