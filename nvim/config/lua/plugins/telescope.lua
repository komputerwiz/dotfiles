return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},

		opts = {
			pickers = {
				buffers = {
					theme = 'ivy',
				},
				find_files = {
					hidden = true,
				},
				lsp_document_symbols = {
					theme = 'cursor',
				},
				lsp_workspace_symbols = {
					theme = 'cursor',
				},
			},
			extensions = {
				file_browser = {
					hidden = true,
					hijack_netrw = true,
					theme = 'ivy',
				},
			},
		},

		config = function(_, opts)
			local telescope = require('telescope')
			local telescope_builtin = require('telescope.builtin')
			telescope.load_extension('file_browser')

			telescope.setup(opts)

			vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = 'Telescope: Files'})

			vim.keymap.set('n', '<Leader>fb', telescope_builtin.buffers, { desc = 'Telescope: Buffers'})
			vim.keymap.set('n', '<Leader>fd', telescope_builtin.diagnostics, { desc = 'Telescope: Diagnostics'})
			vim.keymap.set('n', '<Leader>fe', telescope.extensions.file_browser.file_browser, { desc = 'Telescope: File browser'})
			vim.keymap.set('n', '<Leader>ff', telescope_builtin.find_files, { desc = 'Telescope: Files'})
			vim.keymap.set('n', '<Leader>fg', telescope_builtin.live_grep, { desc = 'Telescope: Grep'})
			vim.keymap.set('n', '<Leader>fh', telescope_builtin.help_tags, { desc = 'Telescope: Help tags'})
			vim.keymap.set('n', '<Leader>fo', telescope_builtin.lsp_document_symbols, { desc = 'Telescope: Document symbols'})
			vim.keymap.set('n', '<Leader>fo', telescope_builtin.lsp_workspace_symbols, { desc = 'Telescope: Workspace symbols'})
		end,
	},
}
