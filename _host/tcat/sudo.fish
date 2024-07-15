function sudo
  set -q sudo_password_file
  and set -lx LC_PASSWORD (gpg --decrypt --quiet "$sudo_password_file" | base64 --wrap=0)

  set -l command
  if test (count $argv) -gt 0
    set command "cd '$PWD' && exec bash -lc 'sudo --askpass $argv'"
  end

  ssh -o SendEnv=LC_PASSWORD sudo $command
end

