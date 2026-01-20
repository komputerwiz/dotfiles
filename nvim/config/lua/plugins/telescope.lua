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
			local bulitin = require('telescope.builtin')

			telescope.setup(opts)
			telescope.load_extension('file_browser')

			vim.keymap.set('n', '<C-p>', bulitin.find_files, { desc = 'Telescope: Files'})

			vim.keymap.set('n', '<Leader>fb', bulitin.buffers, { desc = 'Telescope: Buffers'})
			vim.keymap.set('n', '<Leader>fd', function() bulitin.diagnostics({ bufnr = 0 }) end, { desc = 'Telescope: Diagnostics'})
			vim.keymap.set('n', '<Leader>fD', bulitin.diagnostics, { desc = 'Telescope: Diagnostics'})
			vim.keymap.set('n', '<Leader>fe', telescope.extensions.file_browser.file_browser, { desc = 'Telescope: File browser'})
			vim.keymap.set('n', '<Leader>ff', bulitin.git_files, { desc = 'Telescope: Git Files'})
			vim.keymap.set('n', '<Leader>fg', bulitin.live_grep, { desc = 'Telescope: Grep'})
			vim.keymap.set('n', '<Leader>fh', bulitin.help_tags, { desc = 'Telescope: Help tags'})
			vim.keymap.set('n', '<Leader>fs', bulitin.lsp_document_symbols, { desc = 'Telescope: Document symbols'})
			vim.keymap.set('n', '<Leader>fS', bulitin.lsp_workspace_symbols, { desc = 'Telescope: Workspace symbols'})
		end,
	},
}
