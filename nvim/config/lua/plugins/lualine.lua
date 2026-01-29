return {
	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				-- see 'lua/lualine/themes/solarized_custom.lua'
				theme = 'solarized_custom',
			},
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					'branch',
					'diff',
					'lsp_status',
					'diagnostics',
				},
				lualine_c = {
					{
						'filename',
						path = 1,
					},
				},
			},
		},
	},
}
