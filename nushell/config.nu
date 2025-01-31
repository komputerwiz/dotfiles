# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Theme definition(s): Solarized

# base shading
let base03 = '#002b36'
let base02 = '#073642'
let base01 = '#586e75'
let base00 = '#657b83'
let base0 = '#839496'
let base1 = '#93a1a1'
let base2 = '#eee8d5'
let base3 = '#fdf6e3'

# colors
let yellow = '#b58900'
let orange = '#cb4b16'
let red = '#dc322f'
let magenta = '#d33682'
let violet = '#6c71c4'
let blue = '#268bd2'
let cyan = '#2aa198'
let green = '#859900'

let dark = {
	bg: $base03
	bg_hl: $base02
	fg_muted: $base01
	fg: $base0
	fg_emph: $base1
}

let light = {
	bg: $base3
	bg_hl: $base2
	fg_muted: $base1
	fg: $base00
	fg_emph: $base01
}

def _solarized [base] {
	{
		# primitives
		binary: $base.fg
		block: $base.fg
		bool: $base.fg
		cellpath: $base.fg
		date: $base.fg
		duration: $base.fg
		filesize: $base.fg
		float: $base.fg
		int: $base.fg
		list: $base.fg
		nothing: $base.fg
		range: $base.fg
		record: $base.fg
		string: $base.fg

		# special primitives
		leading_trailing_space_bg: { bg: $base.bg_hl, attr: n }
		header: { fg: $base.fg_emph, attr: b }
		empty: { fg: $blue }
		row_index: { fg: $base.fg_emph, attr: b }
		hints: { fg: $base.fg_muted }

		# shape values (prompt syntax coloring)
		shape_block: { fg: $blue, attr: b }
		shape_bool: { fg: $cyan }
		shape_custom: { attr: b }
		shape_external: { fg: $cyan }
		shape_externalarg: { fg: $green, attr: b }
		shape_filepath: { fg: $cyan }
		shape_flag: { fg: $blue, attr: b }
		shape_float: { fg: $violet, attr: b }
		shape_garbage: { fg: $base.fg_emph, bg: $red, attr: b }
		shape_globpattern: { fg: $cyan, attr: b }
		shape_int: { fg: $violet, attr: b }
		shape_internalcall: { fg: $cyan, attr: b }
		shape_list: { fg: $cyan, attr: b }
		shape_literal: { fg: $blue }
		shape_nothing: { fg: $cyan }
		shape_operator: { fg: $yellow }
		shape_range: { fg: $yellow, attr: b }
		shape_record: { fg: $cyan, attr: b }
		shape_signature: { fg: $green, attr: b }
		shape_string: { fg: $base.fg }
		shape_string_interpolation: { fg: $cyan, attr: b }
		shape_table: { fg: $blue, attr: b }
		shape_variable: { fg: $violet }
	}
}

# Configuration

$env.config.color_config = _solarized $dark
$env.config.show_banner = false

$env.LS_COLORS = (vivid generate solarized-dark | str trim)

# Aliases
# NOTE: Eventually, Atuin will provide alias sync for nushell.
#       In the meantime, use aliases module in dotfiles

alias v = ^$env.EDITOR
