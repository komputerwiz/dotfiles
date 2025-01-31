# Add Composer's global binaries to PATH, using Composer if available.
if (( $+commands[composer] )); then
  export PATH=$PATH:$(composer global config bin-dir --absolute 2>/dev/null)
else
  [ -d $HOME/.composer/vendor/bin ] && export PATH=$PATH:$HOME/.composer/vendor/bin
  [ -d $HOME/.config/composer/vendor/bin ] && export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi
