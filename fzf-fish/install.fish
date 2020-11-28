set -Ux FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
set -U fish_user_paths $fish_user_paths $HOME/.fzf/bin
