function __pyv_get_virtualenvs
  # virtualenv base directory configuration
  set -q XDG_DATA_HOME
  or set -l XDG_DATA_HOME $HOME/.local/share

  set -q PYV_VIRTUALENV_BASE
  or set -l PYV_VIRTUALENV_BASE $XDG_DATA_HOME/pyv

  for file in (ls $PYV_VIRTUALENV_BASE)
    if test -f $PYV_VIRTUALENV_BASE/$file/bin/activate.fish
      echo $file
    end
  end
end

# turn off file completions
complete --command pyv --no-files

# add directories within virtualenv base
complete --command pyv --arguments="(__pyv_get_virtualenvs)"
