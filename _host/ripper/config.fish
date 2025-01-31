# if test -n "$DESKTOP_SESSION"
#   set -x (gnome-keyring-daemon --start | string split '=')
# end

# performing any auto-ssh-add operations with GCR causes a stalled process with 100% CPU usage
# service is typically enabled in the global user scope, but has been disabled temporarily via
# sudo systemctl disable --user --global gcr-ssh-agent.socket
#set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh

# using OpenSSH's ssh-agent until GCR can fix bug with ssh-add
# systemctl enable --user ssh-agent.service
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
