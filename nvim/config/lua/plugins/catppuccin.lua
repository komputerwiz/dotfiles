return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,

		name = "catppuccin",

		opts = {
			auto_integrations = true,
		},

		config = function(_, opts)
			require('catppuccin').setup(opts)

			vim.cmd([[
				try
					colorscheme catppuccin
				catch /.*/
					colorscheme default
				endtry
			]])
		end,
	},
}
