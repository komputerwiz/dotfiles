local M = {}

-- {{{ on_attach() - adjust settings after the language server attaches to the current buffer
local function on_attach(client, bufnr)
	local function bmap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function bopt(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- enable omni-completion (<C-x><C-o>)
	bopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- {{{ key mappings

	-- (see `:h vim.lsp.*` for docs)
	local opts = { noremap = true, silent = true }

	-- {{{ code navigation

	bmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	bmap('n', 'g]', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	bmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	bmap('n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	bmap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

	-- }}}
	-- {{{ inline help

	bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	bmap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

	-- }}}
	-- {{{ workspace management

	bmap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	bmap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	bmap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

	-- }}}
	-- {{{ code manipulation

	bmap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
	bmap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	bmap('n', '<Leader>=', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)

	-- }}}
	-- {{{ diagnostics

	bmap('n', '<Leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
	bmap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	bmap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	bmap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

	-- }}}

	-- }}}
	-- {{{ autocmd and syntax for hovers

	if client.server_capabilities.documentHighlightProvider then
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

	-- }}}
end
M.on_attach = on_attach
-- }}}

M.setup = function(opts)
	opts = opts or {}

	-- allow override of LSP capabilities
	local capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()

	local lspconfig = require('lspconfig')
	require('mason-lspconfig').setup_handlers({
		-- {{{ default settings
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end, -- }}}

		clangd = function() -- {{{
			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = vim.tbl_deep_extend('force', capabilities, {
					offsetEncoding = {'utf-16'},
				}),
			})
		end, -- }}}

		emmet_ls = function() -- {{{
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = {
					'*html*',
					'typescriptreact',
					'javascriptreact',
					'css',
					'sass',
					'scss',
					'less',
				},
				-- init_options = {
				-- 	html = {
				-- 		options = {
				-- 			["bem.enabled"] = true,
				-- 		},
				-- 	},
				-- },
			})
		end, -- }}}

		grammarly = function () -- {{{
			lspconfig.grammarly.setup({
				filetypes = {
					'*markdown*',
					'tex',
				},
				init_options = {
					grammarly = {
						config = {
							suggestions = {
								ConjunctionAtStartOfSentence = true,
								InformalPronounsAcademic = true,
								OxfordComma = true,
								PassiveVoice = true,
								PrepositionAtTheEndOfSentence = true,
								StylisticFragments = true,
								UnnecessaryEllipses = true,
							},
						},
					},
				},
			})
		end, -- }}}

		intelephense = function() -- {{{
			lspconfig.intelephense.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				init_options = {
					licenseKey = 'XXXXXXXXXXXXXXX',
					globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense',
				},
			})
		end, -- }}}

		jdtls = function() -- {{{
			-- workspace path
			if not vim.env.WORKSPACE then
				vim.env.WORKSPACE = vim.env.HOME .. '/ws/jdtls'
			end

			lspconfig.jdtls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { 'jdtls' },
			})
		end, -- }}}

		lua_ls = function() -- {{{
			lspconfig.lua_ls.setup({
				on_attach = function(client, bufnr)
					-- disable document formatting; prefer stylua (provided via null-ls)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
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
		end, -- }}}
	})
end

return M
-- vim: foldmethod=marker foldlevel=0 noexpandtab
