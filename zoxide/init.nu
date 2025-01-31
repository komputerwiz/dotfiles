# NOTE: this file is meant to be run, not linked or sourced
mkdir ($nu.data-dir | path join "vendor/autoload")
zoxide init nu --cmd cd | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
