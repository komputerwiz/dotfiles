# Workaround for `sudo`

TCAT requires the use of two domain accounts:

1.   a regular user that does not have `sudo` access (`matthew.barry`)
2.   a workstation admin that does have `sudo` access (`mbarry-admin`)

As described, this means that every time I need to run a command as root, e.g.,
`apt update`, I would need to:

1.   `su - mbarry-admin` and type the password
2.   `sudo apt update` and type the same password again
3.   `logout`

It is possible to run multiple commands without having to re-enter the password
if I do not log out after step 2 and just leave a persistent `su`-ed terminal
up, but this does not work at all with the `update.d` scripts in my _dotfiles_
repo.

Here I describe a workaround that allows my regular user to run `sudo` without
even needing to type the password once.

## Workstation Admin Setup

The following commands must be run as the workstation admin user
(`mbarry-admin`).

1.  Create a new GPG key without a passphrase and export the public key

    ```bash
    gpg --batch --passphrase '' \
      --quick-gen-key mbarry-admin@mbarry-desktop future-default default never
    gpg --export --output /tmp/mbarry-admin.gpg mbarry-admin@mbarry-desktop
    ```

2.  Create a script to pull the password "out of thin air" (from a magic
    encrypted `LC_PASSWORD` env var) and put it on the `PATH`, i.e., in
    **~/.local/bin/getpass**

    ```bash
    #!/bin/bash
    set -e

    if test -z "$LC_PASSWORD"; then
        exit 1
    fi

    echo -n "$LC_PASSWORD" | base64 --decode | gpg --decrypt --quiet
    ```

3.  Set the `SUDO_ASKPASS` env var to point to this script. Place the following
    in **~/.profile**:

    ```bash
    if [ -n "$LC_PASSWORD" ]; then
      export SUDO_ASKPASS="$HOME/.local/bin/getpass"

      # optionally, for "interactive" sudo/ssh session:
      alias sudo="\\sudo --askpass"
    fi
    ```

## Regular User Setup

Run the following commands as the regular user (`matthew.barry`)

1.  Set up a "sudo" SSH target in **~/.ssh/config**

    ```ini
    Host sudo
    Hostname localhost
    User mbarry-admin
    ```

2.  Copy SSH key to admin user to allow passwordless SSH login

    ```bash
    ssh-copy-id sudo
    ```

3.  Create a new GPG key with a passphrase

    ```bash
    gpg --generate-key
    ```

    When first used, this key's passphrase can be saved in the GNOME keyring
    daemon's _login_ keyring, which is unlocked by PAM at (graphical) login.

4.  Import and sign the workstation admin's GPG public key

    ```bash
    gpg --import /tmp/mbarry-admin.gpg
    gpg --edit-key mbarry-admin
    gpg> sign
    ```

5.  Create a double-layer GPG-encrypted password file. The outer layer will be
    decrypted by the local unprivileged user, and the inner layer will be
    decrypted by the workstation admin user.

    ```bash
    echo -n 'MySuperSecretPassword' \
      | gpg --encrypt --recipient=mbarry-admin \
      | gpg --encrypt --recipient=mbarry@tamu.edu \
      > "$HOME/.local/share/creds/sudo.gpg"
    ```

6.  Use the following script to run commands as sudo:

    ```bash
    export LC_PASSWORD="$(gpg --decrypt "$HOME/.local/share/creds/sudo.gpg" | base64 --wrap=0)"
    ssh -o SendEnv=LC_PASSWORD sudo "cd '$PWD' && bash -lc 'sudo --askpass $@'"

    # alternatively, open an interactive SSH session:
    ssh -o SendEnv=LC_PASSWORD sudo
    ```

## Explanation

When the script runs, the outer layer of the password file is decrypted by GPG
using the passphrase stored within the GNOME keyring daemon's GPG agent. The
encrypted inner payload is then encoded as base64, and the result is stored in
the `LC_PASSWORD` env var. This takes advantage of the fact that the default
SSH config permits `LC_*` env vars to be shared to ensure TTY compatibility.

SSH looks up the `sudo` host from config and logs in as
`mbarry-admin@localhost` using the SSH key, which is stored by GNOME keyring
daemon's SSH agent.

Once authenticated, the following command is run as the workstation admin user:

```bash
cd '$PWD' && bash -lc 'sudo --askpass $@'
```

`$PWD` is substituted with the working directory _from which the script was
called_, so relative paths used in subsequent commands will operate as
expected. Additionally, `$@` is substituted with the command that needs to be
run as root. For example, running `cat ./root-owned-file` in
**/tmp/protected-dir** will send the following over SSH:

```bash
cd '/tmp/protected-dir' && bash -lc 'sudo --askpass cat ./root-owned-file'
```

Note that this pattern does not work if the workstation admin user does not
have permission to access **/tmp/protected-dir**.

The `sudo` command's `--askpass` flag instructs it to use a program that
obtains the password from the user and then outputs it on stdout. This program
defaults to `askpass` on the `PATH`, but can be set to another program via the
`SUDO_ASKPASS` env var.

In this case, we want to set this to run our script that decrypts the
`LC_PASSWORD` env var. However, this env var cannot (and should not) be shared
via SSH, so it must be set in the workstation admin's **~/.profile**. To
prevent this from interfering with other potential use of `sudo --askpass` by
the workstation admin user, we only set this env var if the `LC_PASSWORD` env
var is present This file is not loaded unless the current shell is an
interactive login shell; hence, we use `bash -l` to accomplish this.

The `sudo` command itself is then run within this shell, which:

- has access to the `LC_PASSWORD` env var containing the encrypted password,
- has the `SUDO_ASKPASS` env var set to our special script that decrypts the
  password and passes it to `sudo` via stdout`,
- is run within the working directory from which the script was originally
  invoked, and
- has a pseudo-TTY allocated which permits interactive input via stdin
