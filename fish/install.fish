# fisher plugin manager
curl -sL https://git.io/fisher | source && fisher update

# environment variables
set -Ux EDITOR nvim
set -U fish_user_paths $fish_user_paths $HOME/.local/bin

# miscellaneous colors
set -U fish_color_history_current --bold
