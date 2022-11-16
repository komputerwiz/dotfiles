-- {{{ plugins

require('paq')({
	-- {{{ lua plugins

	'savq/paq-nvim', -- let paq manage itself
	'gpanders/editorconfig.nvim',
	'kyazdani42/nvim-web-devicons',
	'L3MON4D3/LuaSnip',
	'lewis6991/gitsigns.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-lualine/lualine.nvim',
	'simrat39/symbols-outline.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			vim.cmd('TSUpdate')
		end,
	},

	-- {{{ cmp family

	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'saadparwaiz1/cmp_luasnip',

	-- }}}
	-- {{{ telescope family

	'nvim-telescope/telescope.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

	-- }}}
	-- {{{ lsp integration

	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'jose-elias-alvarez/null-ls.nvim',
	'neovim/nvim-lspconfig',

	-- }}}

	-- }}}
	-- {{{ legacy vimscript plugins

	'chaoren/vim-wordmotion',
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
	'jparise/vim-graphql', -- graphql
	-- 'leafgarland/typescript-vim', -- typescript (now built-in)
	'lumiliet/vim-twig', -- twig, htmltwig
	'nblock/vim-dokuwiki', -- dokuwiki
	'neoclide/jsonc.vim', -- jsonc
	-- 'peitalin/vim-jsx-typescript', -- typescriptreact (now built-in)
	'vim-pandoc/vim-criticmarkup', -- criticmarkup

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '+' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append({ '**' })
vim.opt.redrawtime = 500
vim.opt.scrolloff = 1
vim.opt.secure = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
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

local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local gitsigns = require('gitsigns')
local lualine = require('lualine')
local luasnip = require('luasnip')
local mason = require('mason')
local null_ls = require('null-ls')
local telescope = require('telescope')
local tsconfigs = require('nvim-treesitter.configs')
local tsparsers = require('nvim-treesitter.parsers')

-- local modules
local language_servers = require('language-servers')
local snippets = require('snippets')
local tags_source = require('tags-source')

-- }}}
-- {{{ key mappings

do
	local opts = { noremap = true, silent = true }
	local map = vim.api.nvim_set_keymap

	map('n', '<Leader>fb', '<Cmd>Telescope buffers theme=ivy<CR>', opts)
	map('n', '<Leader>fe', '<Cmd>Telescope file_browser<CR>', opts)
	map('n', '<Leader>ff', '<Cmd>Telescope find_files hidden=true<CR>', opts)
	map('n', '<Leader>fg', '<Cmd>Telescope live_grep<CR>', opts)
	map('n', '<Leader>fo', '<Cmd>Telescope lsp_document_symbols theme=cursor<CR>', opts)
	map('n', '<Leader>ft', '<Cmd>Telescope lsp_workspace_symbols theme=cursor<CR>', opts)
	map('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>', opts)
	map('n', '<Leader>h', '<Cmd>Hexmode<CR>', opts)
	map('n', '<Leader>o', '<Cmd>SymbolsOutline<CR>', opts)
	map('n', '<Leader>v', '<Cmd>leftabove split $MYVIMRC<CR>', opts)

	map('', '<F2>', [[<Cmd>let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>]], opts)
	-- map('', '<F3>', '<Cmd>Lexplore<CR>', opts)
	map('', '<F3>', '<Cmd>Telescope file_browser<CR>', opts)

	map('n', '<Space>', 'za', opts)
	map('v', '<Space>', 'za', opts)

	map('x', 'ga', '<Plug>(EasyAlign)', { silent = true })
	map('n', 'ga', '<Plug>(EasyAlign)', { silent = true })

	-- use %% in command mode to insert the directory of the current buffer
	map('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { noremap = true, nowait = true, expr = true })

	-- <C-Space> is treated differently by terminal emulators
	map('i', '<C-Space>', '<C-x><C-o>', opts)
	map('i', '<Nul>', '<C-x><C-o>', opts)

	map('n', '<C-p>', '<Cmd>Telescope find_files hidden=true<CR>', opts)

	-- start new undo sequence for <C-u> and <C-w> in insert mode
	map('i', '<C-u>', '<C-g>u<C-u>', opts)
	map('i', '<C-w>', '<C-g>u<C-w>', opts)
end

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
-- {{{ null-ls

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		tags_source,
	},
	on_attach = language_servers.on_attach,
})

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
-- {{{ nvim-cmp

-- from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip

do
	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
				i = function() -- function(fallback)
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					else
						cmp.abort()
					end
				end,
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
end

-- }}}
-- {{{ nvim-treesitter

tsconfigs.setup({
	highlight = {
		enable = true,
		disable = {
			'php', -- breaks indentation
		},
	},
})

tsparsers.filetype_to_parsername['html.twig'] = 'twig'

-- }}}
-- {{{ rust (built-in)

vim.g.rust_conceal = 1
vim.g.rust_fold = 1

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
	extensions = {
		file_browser = {
			hidden = true,
			hijack_netrw = true,
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
