# Symfony3 basic command completion

_symfony3_get_command_list () {
    php bin/console --no-ansi | sed "1,/Available commands/d" | awk '/^  [a-z]+/ { print $1 }'
}

_symfony2_get_command_list () {
    php app/console --no-ansi | sed "1,/Available commands/d" | awk '/^  [a-z]+/ { print $1 }'
}

_symfony3 () {
    if [ -f bin/console ]; then
        compadd `_symfony3_get_command_list`
    elif [ -f app/console ]; then
        compadd `_symfony2_get_command_list`
    fi
}

compdef _symfony3 bin/console
compdef _symfony3 sf


#Alias

sf() {
    if [ -f bin/console ]; then
        php bin/console $*
    else
        php app/console $*
    fi
}

alias sfcl='sf cache:clear'
alias sfroute='sf router:debug'
alias sfgb='sf generate:bundle'
