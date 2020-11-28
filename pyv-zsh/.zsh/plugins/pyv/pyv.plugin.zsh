pyv () {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "Virtual environment already active: $VIRTUAL_ENV" >&2
    return 1
  fi

  if [ $# -eq 0 ]; then
    if [[ "${(t)ZSH_PYTHON_VIRTUALENV_DIRNAMES}" != array || ${#ZSH_PYTHON_VIRTUALENV_DIRNAMES[@]} -eq 0 ]]; then
      ZSH_PYTHON_VIRTUALENV_DIRNAMES=(.venv env venv)
    fi

    for VENV_DIR in "${ZSH_PYTHON_VIRTUALENV_DIRNAMES[@]}"; do
      if [ -d "$VENV_DIR" -a -f "$VENV_DIR/bin/activate"  ]; then
        source "$VENV_DIR/bin/activate"
        return 0
      fi
    done

    echo "Unable to find virtual environment in current directory" >&2
    return 1
  fi

  ZSH_PYTHON_VIRTUALENV_BASE="${ZSH_PYTHON_VIRTUALENV_BASE:-"$HOME/.virtualenvs"}"
  if [ -f "$ZSH_PYTHON_VIRTUALENV_BASE/$1/bin/activate" ]; then
    source "$ZSH_PYTHON_VIRTUALENV_BASE/$1/bin/activate"
    return 0
  fi

  echo "Unable to find virtual environment $1" >&2
  return 1
}
