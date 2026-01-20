return {
	{
		'neovim/nvim-lspconfig',

		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
		},

		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('*', {
				capabilities = capabilities,
			})

			vim.lsp.config('clangd', {
				capabilities = vim.tbl_deep_extend('force', capabilities, {
					offsetEncoding = {'utf-16'},
				}),
			})

			vim.lsp.config('emmet_ls', {
				filetypes = {
					-- markup/templates
					'html',
					'htmldjango',
					'pug',
					'svelte',
					'twig',
					'vue',
					-- scripts
					'javascript',
					'typescriptreact',
					'javascriptreact',
					-- stylesheets
					'css',
					'less',
					'sass',
					'scss',
				},
				-- init_options = {
				-- 	html = {
				-- 		options = {
				-- 			["bem.enabled"] = true,
				-- 		},
				-- 	},
				-- },
			})

			vim.lsp.config('intelephense', {
				init_options = {
					-- this is set in sysetm.vim from dotter variables in local.toml
					licenseKey = vim.g.intelephense_license_key,
					globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense',
				},
			})

			vim.lsp.config('jdtls', {
				cmd = { 'jdtls' },
			})

			if not vim.env.WORKSPACE then
				vim.env.WORKSPACE = vim.env.HOME .. '/ws/jdtls'
			end

			vim.lsp.config('lua_ls', {
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						diagnostics = {
							globals = {
								'vim',
							},
						},
					},
				},
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('', {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

					-- NOTE: see :h lsp-defaults
					vim.keymap.set('n', 'grD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP: Go to declaration' })

					vim.keymap.set('n', '<LocalLeader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP Diagnostics: open float' })
					vim.keymap.set('n', '<LocalLeader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP Diognostics: open loclist' })

					if client:supports_method('workspace/workspaceFolders') then
						vim.keymap.set('n', '<LocalLeader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP Workspace: add folder' })
						vim.keymap.set('n', '<LocalLeader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP Workspace: remove folder' })
						vim.keymap.set('n', '<LocalLeader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { buffer = true, noremap = true, silent = true, desc = 'LSP Workspace: list folders' })
					end

					if client:supports_method('textDocument/documentHighlight') then
						vim.cmd([[
							augroup lsp_document_highlight
								autocmd!
								autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
								autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
								autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
								autocmd Syntax * highlight link LspReferenceText CursorLine
								autocmd Syntax * highlight link LspReferenceRead LspReferenceText
								autocmd Syntax * highlight link LspReferenceWrite LspReferenceText
							augroup END
						]])
					end
				end
			})

		end,
	},
}
