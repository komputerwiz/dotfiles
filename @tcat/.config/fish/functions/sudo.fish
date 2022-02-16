function sudo
  set -lx LC_PASSWORD (gpg --decrypt --quiet "$sudo_password_file" | base64 --wrap=0)
  ssh -o SendEnv=LC_PASSWORD sudo "cd '$PWD' && bash -lc 'sudo --askpass $argv'"
end

