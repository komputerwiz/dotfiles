export EDITOR='nvim'

export N_PREFIX="$HOME/.local/opt/n"
export RBENV_ROOT="$HOME/.local/opt/rbenv"
export RUSTUP_HOME="$HOME/.local/opt/rustup"

add_user_paths \
  "$HOME/.cargo/bin" \
  "$N_PREFIX/bin" \
  "$RBENV_ROOT/bin"
