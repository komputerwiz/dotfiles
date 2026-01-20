return {
	{
		'Tsuzat/NeoSolarized.nvim',
		lazy = false,
		priority = 1000,

		opts = {
			-- NOTE: commented options represent default values
			-- style = 'dark',
			-- transparent = true
			transparent = false,
			-- terminal_colors = true,
			-- enable_italics = true,
			-- styles = {
			-- 	comments = { italic = true },
			-- 	keywords = { italic = true },
			-- 	functions = { bold = true },
			-- 	variables = {},
			-- 	string = { italic = true },
			-- 	underline = true,
			-- 	undercurl = true,
			-- },
			on_highlights = function(highlights, colors)
				highlights.ColorColumn.bg = colors.bg1
				highlights.CursorColumn = { link = 'CursorLine' }
				highlights.DiffChange.bg = colors.diff_change
				highlights.DiffText.bg = colors.diff_text
			end,
		},

		config = function(_, opts)
			local colors = require('NeoSolarized.colors')

			colors.dark = vim.tbl_extend('force', {}, colors.dark, {
				diff_text = '#404000',
			})

			colors.light = vim.tbl_extend('force', {}, colors.light, {
				diff_add = '#caffca',
				diff_change = '#ffffca',
				diff_delete = '#ffcaca',
				diff_text = '#e8e8b3',
			})

			require('NeoSolarized').setup(opts)

			vim.cmd([[
				try
					colorscheme NeoSolarized
				catch /.*/
					colorscheme default
				endtry
			]])
		end,
	},
}
