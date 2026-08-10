# atuin

[Atuin](https://atuin.sh/) syncs shell history and aliases across `bash`, `zsh`, `fish`, `nushell`, etc.

Sync configuration is pointed at `https://home.komputerwiz.net/atuin`

## Initial Setup

Password is saved in Bitwarden under "Atuin Sync" item.

```bash
atuin login -u komputerwiz
```

Encryption key is also in Bitwarden but can be viewed from another logged in machine:

```bash
atuin key
```

Once logged in, perform initial sync with:

```bash
atuin sync
# optionally, to trigger a full sync if data is missing
atuin sync -f
```

## Updating

Installation via package manager is preferred. However, if `atuin` is installed manually, there is an `atuin-update` command that can be run to check for updates.

The `update.sh` script (symlinked to `update.d/60-atuin.sh` will handle running `atuin-update` (if present) automatically.
