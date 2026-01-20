return {
	{
		'mason-org/mason.nvim',
		opts = {
			ui = {
				icons = {
					package_installed = '●',
					package_pending = '◑',
					package_uninstalled = '○',
				},
			},
		},
	},
	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = {
			'mason-org/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		opts = {
			ensure_installed = {
				'ansiblels',
				'clangd',
				-- codelldb?
				'emmet_ls',
				'intelephense',
				'jdtls',
				'lemminx',
				'lua_ls',
				-- prettierd?
				'pyright',
				'rust_analyzer',
				-- stylua?
				'svelte',
				'texlab',
				'ts_ls',
			},
		},
	},
}
