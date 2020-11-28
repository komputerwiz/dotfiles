set -Ux FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
set -U fish_user_paths $fish_user_paths $HOME/.fzf/bin

if test ! -e $HOME/.config/fish/functions/fzf_key_bindings.fish
  ln -s $HOME/.fzf/shell/key-bindings.fish $HOME/.config/fish/functions/fzf_key_bindings.fish
end
