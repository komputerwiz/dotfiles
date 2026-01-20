return {
	{
		'AISCGre-BR/gregorio.nvim',
		ft = 'gabc',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'neovim/nvim-lspconfig',
		},
		-- main = 'gabc',
		opts = {
			treesitter = {
				enabled = true,
				highlighting = true,
				textobjects = true,
			},
			lsp = {
				enabled = true,
				auto_attach = true,
			},
		},
	},
}
