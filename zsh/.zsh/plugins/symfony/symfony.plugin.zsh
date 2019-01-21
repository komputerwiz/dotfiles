_symfony () {
  compadd $(php bin/console --no-ansi | sed "1,/Available commands/d" | awk '/^  [a-z]+/ { print $1 }')
}

compdef _symfony bin/console
compdef _symfony sf

alias sf='php bin/console'
