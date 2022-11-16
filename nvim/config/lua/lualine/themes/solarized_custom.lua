-- solarized colors
local colors = {
	base03 = '#002b36',
	base02 = '#073642',
	base01 = '#586e75',
	base00 = '#657b83',
	base0 = '#839496',
	base1 = '#93a1a1',
	base2 = '#eee8d5',
	base3 = '#fdf6e3',
	yellow = '#b58900',
	orange = '#cb4b16',
	red = '#dc322f',
	magenta = '#d33682',
	violet = '#6c71c4',
	blue = '#268bd2',
	cyan = '#2aa198',
	green = '#859900',
}

local base_variants = {
	dark = {
		bg = colors.base03,
		bg_hl = colors.base02,
		fg_muted = colors.base01,
		fg = colors.base0,
		fg_emph = colors.base1,
	},
	light = {
		bg = colors.base3,
		bg_hl = colors.base2,
		fg_muted = colors.base1,
		fg = colors.base00,
		fg_emph = colors.base01,
	},
}

-- automatically determine appropriate light/dark theme variant
local base = base_variants[vim.opt.background:get()]

return {
	normal = {
		a = { fg = base.bg, bg = colors.blue, gui = 'bold' },
		b = { fg = base.fg, bg = base.bg_hl },
		c = { fg = base.fg },
	},
	insert = {
		a = { fg = base.bg, bg = colors.green, gui = 'bold' },
	},
	visual = {
		a = { fg = base.bg, bg = colors.magenta, gui = 'bold' },
	},
	replace = {
		a = { fg = base.bg, bg = colors.red, gui = 'bold' },
	},
	command = {
		a = { fg = base.bg, bg = colors.blue, gui = 'bold' },
	},
	inactive = {
		a = { fg = base.fg_muted, bg = base.bg_hl, gui = 'bold' },
		b = { fg = base.fg_muted, bg = base.bg_hl },
		c = { fg = base.fg_muted, bg = base.bg_hl },
	},
}
