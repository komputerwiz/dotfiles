SUDO_PASSWORD_FILE=${SUDO_PASSWORD_FILE:-"$HOME/.local/share/creds/sudo.gpg"}
export LC_PASSWORD="$(gpg --decrypt --quiet "$SUDO_PASSWORD_FILE" | base64 --wrap=0)"

sudo() {
  ssh -o SendEnv=LC_PASSWORD sudo "cd '$PWD' && bash -lc 'sudo --askpass $@'"
}
