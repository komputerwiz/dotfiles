export EDITOR='nvim'
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

# use gnome-keyring as ssh-agent if it's available
if [ -n "$DESKTOP_SESSION" ] && command -v gnome-keyring-daemon >/dev/null 2>&1; then
  export $(gnome-keyring-daemon --start)
fi
