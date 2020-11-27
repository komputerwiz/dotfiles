function sf
  if test ! -f bin/console
    echo -e "\e[31mUnable to locate Symfony console executable (bin/console). Are you in a Symfony project directory?" >&2
    return 1
  end

  if test ! -x bin/console
    echo -e "\e[33mWarning: Symfony console executable (bin/console) is not executable." >&2
  end

  command php bin/console $argv
end

