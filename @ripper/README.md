# Configuration for `ripper` host

    ├── .config
    │   ├── fish
    │   │   └── conf.d
    │   │       └── 99-@ripper.fish
    │   ├── nvim
    │   │   └── plugin
    │   │       └── @ripper.vim
    │   └── systemd
    │       └── user
    │           ├── offlineimap-oneshot@tamu.service.d
    │           │   └── vault.conf
    │           └── offlineimap-oneshot@.timer.d
    │               └── timer.conf
    ├── .local
    │   └── bin
    │       ├── citdfs
    │       ├── mailsync
    │       ├── vault
    │       └── vpn
    ├── install.fish
    └── .stow-local-ignore

# install notes

    source install.fish
