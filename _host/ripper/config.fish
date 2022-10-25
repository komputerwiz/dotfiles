# if test -n "$DESKTOP_SESSION"
#   set -x (gnome-keyring-daemon --start | string split '=')
# end

set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/keyring/ssh

# "equivalent" programs
alias dig='drill'
alias vim='nvim'
