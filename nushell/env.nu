# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
	"PATH": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
	"MANPATH": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
	"INFOPATH": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
	"Path": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
	($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
	($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

if ($'($env.HOME)/.local/bin' | path exists) {
	let-env PATH = ($env.PATH | split row (char esep) | prepend $'($env.HOME)/.local/bin')
}

let-env EDITOR = nvim
let-env VIRTUAL_ENV_DISABLE_PROMPT = true

{{#if homebrew_prefix}}
# Initialize homebrew environment (see docs and output for `brew shellenv`)
let-env HOMEBREW_PREFIX = '{{homebrew_prefix}}'
let-env HOMEBREW_CELLAR = $'($env.HOMEBREW_PREFIX)/Cellar'
let-env HOMEBREW_REPOSITORY = $env.HOMEBREW_PREFIX
let-env PATH = ($env.PATH | split row (char esep) | prepend [
	$'($env.HOMEBREW_PREFIX)/bin'
	$'($env.HOMEBREW_PREFIX)/sbin'
])

# defaults from /etc/manpath.config
if MANPATH not-in $env {
	let-env MANPATH = [
		/usr/man
		/usr/share/man
		/usr/local/man
		/usr/local/share/man
		/usr/X11R6/man
		/opt/man
		/snap/man
	]
}

let-env MANPATH = ($env.MANPATH | split row (char esep) | prepend $'($env.HOMEBREW_PREFIX)/share/man')

# defaults from `info --debug -1 _`
if INFOPATH not-in $env {
	let-env INFOPATH = [
		/usr/info
		/usr/lib/info
		/usr/share/info
		/usr/share/lib/info
		/usr/local/info
		/usr/local/lib/info
		/usr/local/lib/emacs/info
		/usr/local/share/info
		/usr/local/share/lib/info
		/usr/local/emacs/info
		/usr/local/gnu/info
		/usr/local/gnu/lib/info
		/usr/local/gnu/lib/emacs/info
		/usr/gnu/info
		/usr/gnu/lib/info
		/usr/gnu/lib/emacs/info
		/opt/gnu/info
	]
}

let-env INFOPATH = ($env.INFOPATH | split row (char esep) | prepend $'($env.HOMEBREW_PREFIX)/share/info')
{{/if}}
