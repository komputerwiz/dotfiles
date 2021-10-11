set -q XDG_DATA_HOME; or set XDG_DATA_HOME "$HOME/.local/share"
set -g PYV_VIRTUALENV_BASE "$XDG_DATA_HOME/pyv"
