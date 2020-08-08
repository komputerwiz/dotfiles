# Setup for neovim <https://neovim.io/>

    ├── .config
    │   ├── dotfiles
    │   │   └── update.d
    │   │       └── neovim.sh              automatic updater script
    │   └── nvim
    │       ├── compiler
    │       │   ├── phpcs.vim
    │       │   └── tslint.vim
    │       ├── ftdetect
    │       │   └── typescript.vim
    │       ├── ftplugin
    │       │   ├── go.vim
    │       │   ├── json.vim
    │       │   ├── mail.vim
    │       │   ├── python.vim
    │       │   ├── sh.vim
    │       │   └── typescript.vim
    │       ├── plugin
    │       │   ├── binary.vim
    │       │   └── dbext.sec.vim.example  sample connection profiles for dbext extension
    │       ├── spell
    │       │   └── en.utf-8.add           additional words for spell checker
    │       └── init.vim                   base neovim configuration file
    └── .zsh
        └── plugins.d
            └── fzf-neovim.zsh             loads FZF shell ext from neovim installation (if not loaded already)

## see also

* vim
