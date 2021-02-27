# Installation

1. `git clone matthew@git.komputerwiz.net:git/dotfiles.git ~/.dotfiles`
2. `cd ~/.dotfiles`
3. `stow stow`
4. `stow dotfiles <package>...`
5. `echo <package> >> installed`

Some packages have subpackages (prefixed with `@`). See package README for
details and instructions.

# Updating

1. `cd ~/.dotfiles`
2. `git fetch origin <branch>`
3. `stow -D $(cat installed)`
4. `git -c "user.name=<name>" -c "user.email=<email>" rebase origin/<branch>`
5. `stow $(cat installed)`

This process is automated as part of the update script
`~/.config/dotfiles/update.sh`) in the `dotfiles` package.

# Credits

Inspired by [Kraymer's F-dotfiles][].

[f-dotfiles]: https://github.com/Kraymer/F-dotfiles
