# NOTE: brew shellenv doesn't (yet) support nushell.
#       This is a transliteration of its output for bash
$env.HOMEBREW_PREFIX = "{{homebrew_prefix}}"
$env.HOMEBREW_CELLAR = ($env.HOMEBREW_PREFIX | path join "Cellar")
$env.HOMEBREW_REPOSITORY = $env.HOMEBREW_PREFIX

use std/util "path add"
path add ($env.HOMEBREW_PREFIX | path join "bin")
path add ($env.HOMEBREW_PREFIX | path join "sbin")
