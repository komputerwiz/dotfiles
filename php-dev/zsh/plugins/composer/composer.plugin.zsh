alias c='composer'
alias cu='composer update'
alias cr='composer require'
alias crm='composer remove'
alias ci='composer install'
alias ccp='composer create-project'

# Add Composer's global binaries to PATH, using Composer if available.
if (( $+commands[composer] )); then
  export PATH=$PATH:$(composer global config bin-dir --absolute 2>/dev/null)
else
  [ -d $HOME/.composer/vendor/bin ] && export PATH=$PATH:$HOME/.composer/vendor/bin
  [ -d $HOME/.config/composer/vendor/bin ] && export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi
