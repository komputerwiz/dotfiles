# PHP development plugins for fish

This package works in tandem with the `fish` and `php-dev` packages to provide
PHP development utilities for [Symfony][] and [Composer][]. Hence, if the
`fish` package is not stowed, then this package will have no effect.

    └── .config
        └── fish
            ├── conf.d
            │   └── 10-composer-aliases.fish  provides composer aliases
            └── functions
                └── sf.fish                   provides 'sf' alias for symfony framework console

[symfony]: https://symfony.com/
[composer]: https://getcomposer.org/
