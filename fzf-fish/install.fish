set -Ux FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'

if not set -q FZF_DIR
  set -l FZF_DIR $HOME/.fzf
end

set -U fish_user_paths $fish_user_paths $FZF_DIR/bin

if test ! -e $HOME/.config/fish/functions/fzf_key_bindings.fish
  ln -s $FZF_DIR/shell/key-bindings.fish $HOME/.config/fish/functions/fzf_key_bindings.fish
end
