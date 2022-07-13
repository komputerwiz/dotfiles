# if test -n "$DESKTOP_SESSION"
#   set -x (gnome-keyring-daemon --start | string split '=')
# end

set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/keyring/ssh

function alot --wraps 'alot' --description 'run alot with TERM=xterm to fix terminal font color rendering'
  set -lx TERM xterm
  command alot $argv
end

# "equivalent" programs
alias dig='drill'
alias vim='nvim'
