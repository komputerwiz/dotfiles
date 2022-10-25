FZF_DIR="${FZF_DIR:-"$HOME/.fzf"}"

# Auto-completion
[[ $- == *i* ]] && source "$FZF_DIR/shell/completion.bash" 2> /dev/null

# Key bindings
source "$FZF_DIR/shell/key-bindings.bash"
