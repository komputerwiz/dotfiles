function pyv
  if set -q VIRTUAL_ENV
    echo "Virtual environment already active: $VIRTUAL_ENV" >&2
    return 1
  end

  # look for virtual environment identified by name
  if count $argv > /dev/null
    set venv $argv[1]
    if set -q PYV_VIRTUALENV_BASE
      set virtualenv_base $PYV_VIRTUALENV_BASE
    else
      set virtualenv_base $HOME/.virtualenvs
    end

    set activate_script $virtualenv_base/$venv/bin/activate.fish
    if test -f $activate_script
      source $activate_script
      return 0
    end

    echo "Unable to find virtual environment: $venv" >&2
    return 1
  end

  # if no name given, look for virtual environment in current directory
  if set -q PYV_VIRTUALENV_DIRNAMES
    set dirnames $PYV_VIRTUALENV_DIRNAMES
  else
    set dirnames .venv env venv
  end
  for venv_dir in $dirnames
    set activate_script $venv_dir/bin/activate.fish
    if test -f $activate_script
      source $activate_script
      return 0
    end
  end

  echo "Unable to find virtual environment in current directory" >&2
  return 1
end

