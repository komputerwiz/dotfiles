# Setup for neovim <https://neovim.io/>

    └── .config
        ├── dotfiles
        │   └── update.d
        │       └── neovim.sh              automatic updater script
        └── nvim
            ├── compiler
            │   ├── phpcs.vim
            │   ├── tslint.vim
            │   └── typescriptreact.vim
            ├── ftdetect
            │   ├── cshtml.vim
            │   └── gabc.vim
            ├── ftplugin
            │   ├── cpp.vim
            │   ├── go.vim
            │   ├── json.vim
            │   ├── mail.vim
            │   ├── make.vim
            │   ├── markdown.vim
            │   ├── python.vim
            │   ├── sh.vim
            │   ├── typescriptreact.vim
            │   └── typescript.vim
            ├── indent
            │   └── typescriptreact.vim
            ├── plugin
            │   ├── binary.vim
            │   └── scratch.vim
            ├── spell
            │   └── en.utf-8.add           additional words for spell checker
            ├── syntax
            │   ├── gabc.vim
            │   └── typescriptreact.vim
            ├── UltiSnips
            │   ├── all.snippets
            │   ├── cpp.snippets
            │   ├── c.snippets
            │   ├── html.snippets
            │   ├── mail.snippets
            │   ├── mediawiki.snippets
            │   ├── php.snippets
            │   ├── sh.snippets
            │   ├── tex.snippets
            │   └── xml.snippets
            └── init.lua                   base neovim configuration file

## Installation Instructions

[paq](https://github.com/savq/paq-nvim) needs to be cloned manually first, then bootstrapped with other plugins:

    git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/start/paq-nvim
    nvim +PaqInstall +qa

## see also

* vim
