# NOTE: this file is meant to be run, not linked or sourced
mkdir ($nu.data-dir | path join "vendor/autoload")
mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/90-mise.nu")
