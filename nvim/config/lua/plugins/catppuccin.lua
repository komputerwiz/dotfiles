return {
	{
		'catppuccin/nvim',
		lazy = false,
		priority = 1000,

		name = 'catppuccin',

		opts = {
			auto_integrations = true,
		},

		config = function(_, opts)
			require('catppuccin').setup(opts)

			vim.cmd([[
				try
					colorscheme catppuccin-nvim
				catch /.*/
					echom "Failed to set colorscheme to catppuccin-nvim; falling back to default."
					colorscheme default
				endtry
			]])
		end,
	},
}
