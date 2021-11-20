# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

add_user_paths() {
  for ARG in "$@"; do
    if test -d "$ARG"; then
      if echo ":$PATH:" | grep -qv ":$ARG:"; then
        PATH="$ARG:$PATH"
      fi
    fi
  done
}

add_user_paths \
  "$HOME/.local/bin"

for FILE in "${XDG_CONFIG_HOME:-"$HOME/.config"}/bash/env.d/"*".sh"; do
  if test -f "$FILE"; then
    . "$FILE"
  fi
done

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
