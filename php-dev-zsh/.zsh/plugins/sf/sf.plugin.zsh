sf () {
  if [ ! -f bin/console ]; then
    echo -e "\e[31mUnable to locate Symfony console executable (bin/console). Are you in a Symfony project directory?" >&2
    return 1
  fi

  if [ ! -x bin/console ]; then
    echo -e "\e[33mWarning: Symfony console executable (bin/console) is not executable." >&2
  fi

  php bin/console $@
}
