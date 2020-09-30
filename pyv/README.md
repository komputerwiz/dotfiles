# Python Virtual Environment Source-ery

    ├── .virtualenvs                Placeholder directory for 'global' virtual environments
    │   └── .gitignore
    └── .zsh
        ├── plugins
        │   └── pyv
        │       ├── _pyv            ZSH completions
        │       └── pyv.plugin.zsh  pyv function definition
        └── plugins.d
            └── pyv.zsh             ZSH plugin autoloader

## Configuration Variables

The behavior of `pyv` can be configured with the following variables (default values shown):

    # which directories (within $PWD) should be searched for 'local' virtual environment
    ZSH_PYTHON_VIRTUALENV_DIRNAMES=(.venv env venv)

    # location of 'global' virtual environments
    ZSH_PYTHON_VIRTUALENV_BASE="$HOME/.virtualenvs"

