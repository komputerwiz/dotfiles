# ZSH configuration

    ├── .config
    │   └── dotfiles
    │       └── update.d
    │           └── zsh.zsh                     automatic updater
    ├── .zsh
    │   ├── antigenrc                           configuration for antigen bundle system
    │   ├── plugins
    │   │   └── reboot-notifier
    │   │       └── reboot-notifier.plugin.zsh  adds indicator to prompt when reboot is required
    │   └── themes
    │       └── komputerwiz.zsh-theme           prompt theme
    │
    ├── .zshenv                                 sourced first and unconditionally
    ├── .zprofile                               sourced before .zshrc only for login shells
    ├── .zshrc                                  sourced only for interactive shells
    ├── .zlogin                                 sourced after .zshrc only for login shells
    ├── .zlogout                                sourced when logging out
    │
    └── install.sh                              installation script

## install notes

1. `stow zsh`
2. `./zsh/install.sh`
