# PHP development plugins for ZSH

This package works in tandem with the `zsh` package to provide PHP development
utilities for [Symfony][] and [Composer][]. Hence, if the `zsh` package is not
stowed, then this package will have no effect.

    └── .zsh
        ├── plugins
        │   └── sf
        │       ├── sf.plugin.zsh  provides 'sf' alias for Symfony framework console
        │       └── _sf            autocompletion for 'sf' alias
        └── plugins.d
            └── php-dev.zsh        loads 'sf' and 'composer' plugins

[symfony]: https://symfony.com/
[composer]: https://getcomposer.org/
