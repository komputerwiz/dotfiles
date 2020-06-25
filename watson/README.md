# Watson plugin for ZSH

This package works in tandem with the `zsh` package to provide aliases and
completion for [Watson][]. Hence, if the `zsh` package is not stowed, then this
package will have no effect.

    ├── .config
    │   └── watson
    │       ├── .gitignore             ignores other watson data files (these should technically go in $XDG_DATA_DIR)
    │       └── config                 watson configuration file
    └── .zsh
        ├── plugins
        │   └── watson
        │       ├── watson.plugin.zsh  provides watson aliases
        │       └── _watson            autocompletion for 'watson'
        └── plugins.d
            └── watson.zsh             loads 'watson' plugin

[watson]: http://tailordev.github.io/Watson/

## install notes

Be sure to `antigen reset` after stowing.
