-- {{{ plugins

-- {{{ paq bootstrap

do
	local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
	if vim.fn.empty(vim.fn.glob(path)) > 0 then
		vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path })
	end
end

-- }}}

require('paq')({
	-- {{{ lua plugins

	'savq/paq-nvim', -- let paq manage itself
	'chrisgrieser/nvim-spider',
	'cpea2506/relative-toggle.nvim',
	'kyazdani42/nvim-web-devicons',
	'L3MON4D3/LuaSnip',
	'lewis6991/gitsigns.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-lualine/lualine.nvim',
	'simrat39/symbols-outline.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			vim.cmd('TSUpdate')
		end,
	},
	'windwp/nvim-autopairs',

	-- {{{ cmp family

	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'saadparwaiz1/cmp_luasnip',
	'uga-rosa/cmp-dictionary',

	-- }}}
	-- {{{ telescope family

	'nvim-telescope/telescope.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

	-- }}}
	-- {{{ lsp/dap integration

	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'mfussenegger/nvim-dap',
	'neovim/nvim-lspconfig',
	'rcarriga/nvim-dap-ui',

	-- }}}

	-- }}}
	-- {{{ legacy vimscript plugins

	'duggiefresh/vim-easydir',
	'junegunn/vim-easy-align',
	'nelstrom/vim-visual-star-search',
	'ntpeters/vim-better-whitespace',
	'overcache/NeoSolarized',
	'tpope/vim-abolish',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-unimpaired',

	-- {{{ syntax/filetype

	'dag/vim-fish', -- fish
	{ 'jparise/vim-graphql', as = 'graphql', opt = true },
	{ 'lumiliet/vim-twig', as = 'twig', opt = true },
	{ 'nblock/vim-dokuwiki', as = 'dokuwiki', opt = true },
	{ 'neoclide/jsonc.vim', as = 'jsonc', opt = true },
	{ 'vim-pandoc/vim-criticmarkup', as = 'criticmarkup', opt = true },

	-- }}}

	-- }}}
})

-- }}}
-- {{{ syntax highlighting

vim.cmd('colorscheme NeoSolarized')

-- force whitespace highlighting to look like comments
vim.cmd([[
	augroup mysyntax
		autocmd! Syntax,BufNewFile,BufReadPost * highlight link Whitespace Comment
	augroup END
]])

-- }}}
-- neovide gui {{{
if vim.g.neovide then
	vim.o.guifont = 'FiraCode Nerd Font:h9'
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_transparency = 1.0
	vim.g.neovide_floating_blur_amount_x = 3.0
	vim.g.neovide_floating_blur_amount_y = 3.0
end
-- }}}
-- {{{ options

vim.opt.background = 'dark'
vim.opt.colorcolumn = { 80, 92, 100, 120 }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- {'longest', 'menu'}
vim.opt.concealcursor = 'c'
vim.opt.conceallevel = 2
vim.opt.expandtab = false
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.listchars = {
	tab = '» ',
	lead = '·',
	trail = '·',
	nbsp = '␣',
	precedes = '⟨',
	extends = '⟩',
}
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append({ '**' })
vim.opt.redrawtime = 500
vim.opt.scrolloff = 1
vim.opt.secure = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showbreak = '↪ '
vim.opt.sidescrolloff = 5
vim.opt.softtabstop = 2
vim.opt.spelllang = 'en_us'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 1000
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.wrap = false

-- }}}
-- {{{ imports

local autopairs = require('nvim-autopairs')
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_dictionary = require('cmp_dictionary')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local dap = require('dap')
local dap_ext_vscode = require('dap.ext.vscode')
local dap_ui = require('dapui')
local gitsigns = require('gitsigns')
local lualine = require('lualine')
local luasnip = require('luasnip')
local mason = require('mason')
local mason_registry = require('mason-registry')
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local tsconfigs = require('nvim-treesitter.configs')

-- local modules
local language_servers = require('language-servers')
local snippets = require('snippets')

-- }}}
-- {{{ key mappings

vim.keymap.set('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>')
vim.keymap.set('n', '<Leader>fb', telescope_builtin.buffers)
vim.keymap.set('n', '<Leader>fe', telescope.extensions.file_browser.file_browser)
vim.keymap.set('n', '<Leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<Leader>fg', telescope_builtin.live_grep)
vim.keymap.set('n', '<Leader>fh', telescope_builtin.help_tags)
vim.keymap.set('n', '<Leader>fo', telescope_builtin.lsp_document_symbols)
vim.keymap.set('n', '<Leader>fo', telescope_builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<Leader>gh', '<Cmd>0Gclog<CR>')
vim.keymap.set('n', '<Leader>h', '<Cmd>Hexmode<CR>')
vim.keymap.set('n', '<Leader>o', '<Cmd>SymbolsOutline<CR>')
vim.keymap.set('n', '<Leader>v', '<Cmd>leftabove split $MYVIMRC<CR>')

vim.keymap.set('', '<F2>', function() vim.opt.background = vim.o.background == 'dark' and 'light' or 'dark' end, { desc = 'toggle-dark-mode' })
vim.keymap.set('n', '<F3>', telescope.extensions.file_browser.file_browser)
vim.keymap.set('n', '<F4>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_into)
vim.keymap.set('n', '<F7>', dap.step_over)
vim.keymap.set('n', '<F8>', dap.step_out)
vim.keymap.set('n', '<F9>', dap.restart_frame)
vim.keymap.set('n', '<F10>', dap.terminate)
vim.keymap.set('n', '<F11>', dap.run_to_cursor)
vim.keymap.set('n', '<F12>', dap_ui.toggle)

-- these have to be ex commands in order for dot-repeat to work
vim.keymap.set({'n', 'o', 'x'}, 'w', [[<Cmd>lua require('spider').motion('w')<CR>]], { desc = 'spider-w' })
vim.keymap.set({'n', 'o', 'x'}, 'e', [[<Cmd>lua require('spider').motion('e')<CR>]], { desc = 'spider-e' })
vim.keymap.set({'n', 'o', 'x'}, 'b', [[<Cmd>lua require('spider').motion('b')<CR>]], { desc = 'spider-b' })
vim.keymap.set({'n', 'o', 'x'}, 'ge',[[<Cmd>lua require('spider').motion('ge')<CR>]], { desc = 'spider-ge' })

vim.keymap.set({'n', 'v'}, '<Space>', 'za')

vim.keymap.set({'n', 'x'}, 'ga', '<Plug>(EasyAlign)', { remap = true })

-- use %% in command mode to insert the directory of the current buffer
vim.keymap.set('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { nowait = true, expr = true })

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files)

-- start new undo sequence for <C-u> and <C-w> in insert mode
vim.keymap.set('i', '<C-u>', '<C-g>u<C-u>')
vim.keymap.set('i', '<C-w>', '<C-g>u<C-w>')

-- }}}
-- {{{ commands and functions

do
	local command = vim.api.nvim_create_user_command

	-- delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
	command('Delete', function(o)
		vim.fn.delete(vim.fn.expand('%:p'))
		vim.cmd('bdelete' .. (o.bang and '!' or ''))
	end, {
		bar = true,
		bang = true,
	})

	-- set tabstop, softtab, and shiftwidth to the same value
	command('Stab', function(o)
		local width = tonumber(o.args)
		if width > 0 then
			vim.opt_local.softtabstop = width
			vim.opt_local.tabstop = width
			vim.opt_local.shiftwidth = width
		end
	end, { nargs = 1 })

	-- load scriptnames into a scratch buffer
	command('Scriptnames', 'Scratch scriptnames <f-args>', { nargs = '?' })

	-- simplify colorscheme for non-true-color terminals
	command('SimpleColors', function()
		vim.opt.termguicolors = false
		vim.cmd('colorscheme default')
	end, {})
end

-- }}}
-- {{{ plugin config

-- {{{ dokuwiki

vim.g.dokuwiki_fenced_languages = { 'bash=sh', 'javascript', 'php', 'ruby' }

-- }}}
-- {{{ gitsigns

gitsigns.setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- navigation
		map('n', ']c', function()
			if vim.wo.diff then
				return ']c'
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[c', function()
			if vim.wo.diff then
				return ']c'
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return '<Ignore>'
		end, { expr = true })
	end,
})

-- }}}
-- lualine {{{

lualine.setup({
	options = {
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
		lualine_c = {
			{
				'filename',
				path = 1,
			},
		},
	},
})

-- }}}
-- {{{ luasnip

-- this configuration is too large and complex to fit here and has been broken
-- into a separate file
snippets.setup()

-- }}}
-- {{{ markdown (built-in)

vim.g.markdown_folding = 1
vim.g.markdown_recommended_style = 0

-- }}}
-- {{{ mason

mason.setup({
	ui = {
		icons = {
			package_installed = '●',
			package_pending = '◑',
			package_uninstalled = '○',
		},
	},
})

-- }}}
-- {{{ netrw (vim's built-in file browser)

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- }}}
-- {{{ NeoSolarized

-- NOTE: commented options represent default values

-- font styles
-- vim.g.neosolarized_bold = 1
vim.g.neosolarized_italic = 1
-- vim.g.neosolarized_underline = 1

-- appearance
-- vim.g.neosolarized_contrast = 'normal'
-- vim.g.neosolarized_diffmode = 'normal'
-- vim.g.neosolarized_termBoldAsBright = 1
-- vim.g.neosolarized_termtrans = 0
-- vim.g.neosolarized_visibility = 'normal'
-- vim.g.neosolarized_vertSplitBgTrans = 1

-- }}}
-- {{{ nvim-autopairs

autopairs.setup({})

-- }}}
-- {{{ nvim-cmp

-- from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip

do
	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
	end

	local function snip_choice_or_abort()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		else
			cmp.abort()
		end
	end


	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping({
				i = snip_choice_or_abort,
				s = snip_choice_or_abort,
				c = cmp.mapping.close(),
			}),

			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					-- cmp.select_next_item()
					cmp.confirm({ select = true }) -- set to 'false' to force selection
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				-- if cmp.visible() then
				-- cmp.select_prev_item()
				-- elseif luasnip.jumpable(-1) then
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		}),

		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		}, {
			{ name = 'path' },
		}, {
			{ name = 'buffer' },
			{ name = 'dictionary', keyword_length = 2 },
		}),
	})

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})

	-- automatically insert `(` after autocompleting a function or method
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

	cmp_dictionary.setup({})

	cmp_dictionary.switcher({
		filetype = {
			markdown = vim.fn.expand('$HOME/callsigns.dict'),
		},
	})
end

-- }}}
-- {{{ nvim-dap / nvim-dap-ui

dap_ext_vscode.type_to_filetypes = {
	lldb = { 'c', 'cpp', 'rust' },
}

vim.fn.sign_define('DapBreakpoint', { text = '', texthl='', linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl='', linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl='', linehl='', numhl='' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl='', linehl='', numhl='' })

if mason_registry.is_installed('codelldb') then
	local codelldb = mason_registry.get_package('codelldb')
	dap.adapters.codelldb = {
		type = 'server',
		port = '${port}',
		executable = {
			command = codelldb:get_install_path() .. '/extension/adapter/codelldb',
			args = {
				'--port',
				'${port}',
			},
		},
	}

	dap.adapters.lldb = dap.adapters.codelldb

	--[[
	dap.configurations.cpp = {
		{
			name = 'Launch file',
			type = 'codelldb',
			request = 'launch',
			program = function ()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}

	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp
	--]]
end

dap_ui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function ()
	dap_ui.open()
end

dap.listeners.after.event_terminated['dapui_config'] = function ()
	dap_ui.close()
end

dap.listeners.after.event_exited['dapui_config'] = function ()
	dap_ui.close()
end

-- }}}
-- {{{ nvim-treesitter

tsconfigs.setup({
	ensure_installed = {
		'bash',
		'bibtex',
		'c',
		'c_sharp',
		'cmake',
		'comment',
		'cpp',
		'css',
		'diff',
		'dockerfile',
		'dot',
		'ebnf',
		'fish',
		'git_rebase',
		'gitattributes',
		'gitcommit',
		'go',
		'gomod',
		'gowork',
		'graphql',
		'haskell',
		'html',
		'http',
		'java',
		'javascript',
		'jq',
		'jsdoc',
		'json',
		'json5',
		'jsonc',
		'latex',
		'lua',
		'make',
		'markdown',
		'markdown_inline',
		'meson',
		'ninja',
		'php',
		'phpdoc',
		'pug',
		'python',
		'regex',
		'rst',
		'ruby',
		'rust',
		'scss',
		'sql',
		'svelte',
		'todotxt',
		'toml',
		'tsx',
		'twig',
		'typescript',
		'vim',
		'vimdoc',
		'yaml',
	},
	highlight = {
		enable = true,
		disable = {
			'php', -- breaks indentation
		},
	},
})

vim.treesitter.language.register('twig', 'html.twig') -- use 'twig' parser to handle 'html.twig' filetype

-- }}}
-- {{{ rust (built-in)

vim.g.rust_conceal = 1
vim.g.rust_fold = 1
vim.g.rust_recommended_style = 0

-- }}}
-- {{{ symbols-outline

vim.g.symbols_outline = {
	auto_preview = false,
	symbols = {
		File = { icon = 'file' },
		Module = { icon = 'mod' },
		Namespace = { icon = '∷' },
		Package = { icon = 'pkg' },
		Class = { icon = 'Ϲ' },
		Method = { icon = 'µ' },
		Property = { icon = '+' },
		Field = { icon = '-' },
		Constructor = { icon = '¢' },
		Enum = { icon = 'Ε' },
		Interface = { icon = 'Ι' },
		Function = { icon = 'ƒ' },
		Variable = { icon = 'ν' },
		Constant = { icon = 'π' },
		String = { icon = '$' },
		Number = { icon = '#' },
		Boolean = { icon = '!' },
		Array = { icon = '@' },
		Object = { icon = '⊙' },
		Key = { icon = 'κ' },
		Null = { icon = '∅' },
		EnumMember = { icon = '·' },
		Struct = { icon = '§' },
		Event = { icon = '&' },
		Operator = { icon = '⊕' },
		TypeParameter = { icon = 'Τ' },
	},
}

-- }}}
-- {{{ telescope

telescope.setup({
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
})

telescope.load_extension('file_browser')

-- }}}
-- {{{ tex (built-in)

vim.g.tex_flavor = 'latex'

-- }}}

-- }}}
-- {{{ language server (LSP) config

language_servers.setup({
	capabilities = cmp_nvim_lsp.default_capabilities(),
})

-- }}}
-- {{{ automatically source file after editing

vim.cmd([[
	augroup vimrc
		autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
	augroup END
]])

-- }}}

-- vim: foldmethod=marker foldlevel=0 noexpandtab
