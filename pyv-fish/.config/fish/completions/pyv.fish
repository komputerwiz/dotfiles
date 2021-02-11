function __pyv_get_virtualenvs
  # virtualenv base directory configuration
  set -l venv_base $HOME/.virtualenvs
  if set -q PYV_VIRTUALENV_BASE
    set venv_base $PYV_VIRTUALENV_BASE
  end

  for file in (ls $venv_base)
    if test -f $venv_base/$file/bin/activate.fish
      echo $file
    end
  end
end

# turn off file completions
complete --command pyv --no-files

# add directories within virtualenv base
complete --command pyv --arguments="(__pyv_get_virtualenvs)"
