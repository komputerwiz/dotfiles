export EDITOR='nvim'

export FZF_DIR="$HOME/.local/opt/fzf"
export N_PREFIX="$HOME/.local/opt/n"
export RBENV_ROOT="$HOME/.local/opt/rbenv"
export RUSTUP_HOME="$HOME/.local/opt/rustup"

add_user_paths \
  "$HOME/.cargo/bin" \
  "$FZF_DIR/bin" \
  "$N_PREFIX/bin" \
  "$RBENV_ROOT/bin"
