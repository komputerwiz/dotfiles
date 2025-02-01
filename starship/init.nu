# NOTE: this file is meant to be run, not linked or sourced
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/90-starship.nu")
