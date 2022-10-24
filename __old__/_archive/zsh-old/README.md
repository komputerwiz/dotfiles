# A Power-User's ZSH Configuration

Author: Matthew J. Barry
License: MIT

## Installation
To install, clone this repository to your ZSH config directory.

**NOTE:** All scripts assume that the current working directory is your home directory.

    cd $HOME
    git glone git://github.com/komputerwiz/zsh-config.git .zsh

You can use the provided install script to get things set up quickly

    .zsh/install.sh

This will check that z-shell is installed, prompt to install [oh-my-zsh][], prompt to change your default shell to `/bin/zsh` if not set already, and symlink zsh startup files. If you prefer to install manually, then use the following steps as needed:

1.  Install [oh-my-zsh][]

        git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh

2.  Set your shell to ZSH

        chsh -s /bin/zsh

3.  Symlink ZSH dotfiles. Back up existing files to merge into existing dotfiles or as machine-specific dotfiles (see next section for more details)

        ln -s .zsh/zlogin .zlogin
        ln -s .zsh/zlogout .zlogout
        ln -s .zsh/zprofile .zprofile
        ln -s .zsh/zshenv .zshenv
        ln -s .zsh/zshrc .zshrc

4.  If you would like to use my terminal theme `komputerwiz`, symlink the file to the `~/.oh-my-zsh/themes` directory.
        
        ln -s .zsh/oh-my-zsh/komputerwiz.zsh-theme .oh-my-zsh/themes/


## Machine-Specific Dotfiles
If you have multiple computers, consider adding a folder in `~/.zsh/host/` that corresponds to the computer's hostname, that is, the output of `uname -n` or `hostname` (only up to the first dot). Any of the `z*` files in this directory will be loaded automatically before the contents of `~/.zsh/z*`. Appending `-after` to will cause those files to be loaded after `~/.zsh/z*` has finished.

For example, `~/.zsh/host/computer-name/zshrc` will be loaded prior to the primary execution of `~/.zsh/zshrc`, and `~/.zsh/host/computer-name/zshrc-after` will be executed afterwards.

If your computer has a dynamic hostname, you can put your computer's `z*` files in your home directory with a `.local` suffix. Using the same example, `~/.zsh/host/computer-name/zshrc` would become `~/.zshrc.local`, and `~/.zsh/host/computer-name/zshrc-after` would become `~/.zshrc-after.local`.

[oh-my-zsh]: http://github.com/robbyrussell/oh-my-zsh
