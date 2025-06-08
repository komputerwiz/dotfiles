atuin init fish | source

# Workaround for 18.6.1 until next release
# See https://github.com/atuinsh/atuin/issues/2718
bind up _atuin_bind_up
bind -M insert up _atuin_bind_up
