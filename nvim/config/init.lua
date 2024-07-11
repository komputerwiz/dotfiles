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
	'kylechui/nvim-surround',
	'L3MON4D3/LuaSnip',
	'lewis6991/gitsigns.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-lualine/lualine.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			vim.cmd('TSUpdate')
		end,
	},
	'stevearc/oil.nvim',
	'simrat39/symbols-outline.nvim',
	'Tsuzat/NeoSolarized.nvim',
	'windwp/nvim-autopairs',

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
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

	-- }}}
	-- {{{ lsp/dap integration

	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'mfussenegger/nvim-dap',
	'neovim/nvim-lspconfig',
	'rcarriga/nvim-dap-ui',
	'nvim-neotest/nvim-nio', -- required for nvim-dap-ui

	-- }}}

	-- }}}
	-- {{{ legacy vimscript plugins

	'duggiefresh/vim-easydir',
	'junegunn/vim-easy-align',
	'nelstrom/vim-visual-star-search',
	'ntpeters/vim-better-whitespace',
	'tpope/vim-abolish',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
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
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local dap = require('dap')
local dap_ext_vscode = require('dap.ext.vscode')
local dap_ui = require('dapui')
local gitsigns = require('gitsigns')
local lspconfig = require('lspconfig')
local lualine = require('lualine')
local luasnip = require('luasnip')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_registry = require('mason-registry')
local neosolarized = require('NeoSolarized')
local oil = require('oil')
local surround = require('nvim-surround')
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local tsconfigs = require('nvim-treesitter.configs')

-- }}}
-- {{{ key mappings

vim.keymap.set('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>')
vim.keymap.set('n', '<Leader>fb', telescope_builtin.buffers)
vim.keymap.set('n', '<Leader>fd', telescope_builtin.diagnostics)
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

do
	local ls = luasnip
	local types = require('luasnip.util.types')

	-- {{{ shorthand variables

	local s = ls.snippet
	local sn = ls.snippet_node
	local t = ls.text_node
	local i = ls.insert_node
	local f = ls.function_node
	local c = ls.choice_node
	local d = ls.dynamic_node
	local r = ls.restore_node

	-- }}}
	-- {{{ helper functions

	-- copies the text value of another text field
	local function copy(args)
		return args[1]
	end

	-- traditional functional map operation
	local function map(tbl, fn)
		local rv = {}
		for key, val in pairs(tbl) do
			rv[key] = fn(val)
		end
		return rv
	end

	-- capitalize the first letter of a word
	local function capitalize(args)
		local capitalized = table.concat(args[1]):gsub('^%l', string.upper)
		return sn(nil, i(1, capitalized))
	end

	-- generates a new random v4 UUID
	local function uuid4()
		local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
		return template:gsub('[xy]', function(ch)
			local v = (ch == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
			return string.format('%x', v)
		end)
	end

	local function filename_node(num, placeholder)
		return d(num, function()
			local classname = vim.fn.expand('%:t:r')
			if classname == '' then
				-- fallback for placeholder text
				classname = placeholder or 'MyType'
			end
			return sn(nil, i(1, classname))
		end)
	end

	-- recursive delimited expansion
	local function rec_delim(args, parent, old_state, delim, placeholder)
		return sn(
			nil,
			c(1, {
				t(''), -- putting sn(...) first causes infinite loop
				sn(nil, {
					t(delim),
					i(1, placeholder),
					d(2, rec_delim, {}, { user_args = { delim, placeholder } }),
				}),
			})
		)
	end

	-- }}}

	-- {{{ luasnip configuration

	ls.config.set_config({
		history = true,
		updateevents = 'TextChanged,TextChangedI',
		-- enable_autosnippets = true,
		ext_opts = {
			-- display `snip:choice` at end of line when choice node is active
			[types.choiceNode] = {
				active = {
					virt_text = { { 'snip:choice (<C-e>)', 'Comment' } },
				},
			},
		},
	})

	-- }}}
	-- {{{ snippet definitions

	-- {{{ global snippets

	ls.add_snippets('all', {
		s(
			{ trig = 'date', name = 'ISO 8601 Date' },
			f(function()
				return os.date('%F')
			end)
		),

		s(
			{ trig = 'time', name = 'ISO 8601 Time' },
			f(function()
				return os.date('%T')
			end)
		),

		s(
			{ trig = 'timetz', name = 'ISO 8601 Time with Timezone Offset' },
			f(function()
				return os.date('%T%z')
			end)
		),

		s(
			{ trig = 'datetime', name = 'ISO 8601 Date and Time' },
			f(function()
				return os.date('%F %T')
			end)
		),

		s(
			{ trig = 'datetimetz', name = 'ISO 8601 Date and Time with Timezone Offset' },
			f(function()
				return os.date('%F %T%z')
			end)
		),

		s('shrug', t('¯\\_(ツ)_/¯')),
		s({ trig = 'uuid', name = 'Random UUIDv4' }, f(uuid4)),
	})

	-- }}}
	-- {{{ c

	ls.add_snippets('c', {
		s({ trig = 'ifnd', name = '#ifndef Header Guard' }, {
			t('#ifndef '),
			i(1),
			t({ '', '#define ' }),
			f(copy, 1),
			t({ '', '', '' }),
			i(0),
			t({ '', '', '' }),
			t('#endif // '),
			f(copy, 1),
		}),
	})

	-- }}}
	-- {{{ cpp

	ls.add_snippets('cpp', {
		s({
			trig = 'ro5',
			wordTrig = false,
			name = 'Rule of 5',
			dscr = 'Member functions on a class or struct whose definitions '
					.. 'should be defined together: copy/move constructors, copy/move '
					.. 'assignment operators, and destructor',
		}, {
			i(1),
			t('('),
			f(copy, 1),
			t({ ' const&) = default;', '' }),
			f(copy, 1),
			t('('),
			f(copy, 1),
			t({ '&&) noexcept = default;', '' }),
			f(copy, 1),
			t('& operator=('),
			f(copy, 1),
			t({ ' const&) = default;', '' }),
			f(copy, 1),
			t('& operator=('),
			f(copy, 1),
			t({ '&&) noexcept = default;', '' }),
			t('~'),
			f(copy, 1),
			t({ '() = default;', '' }),
		}),
	})

	-- }}}
	-- {{{ java

	ls.add_snippets('java', {
		s({ trig = 'logger', name = 'System Logger for class' }, {
			t('private static final Logger logger = System.getLogger('),
			filename_node(1),
			t('.class.getName());'),
		}),

		s({ trig = 'fori', name = 'for (i)' }, {
			t('for (int '),
			i(1, 'i'),
			t(' = 0; '),
			f(copy, 1),
			t(' < '),
			i(2, 'max'),
			t('; '),
			f(copy, 1),
			t('++)'),
		}),

		s({ trig = 'fore', name = 'for (each)' }, {
			t('for (var '),
			i(1, 'item'),
			t(' : '),
			i(2, 'collection'),
			t(')'),
		}),

		s('class', {
			c(1, {
				t('public '),
				t('private '),
			}),
			c(2, {
				t(''),
				t('static '),
			}),
			t('class '),
			filename_node(3, 'MyClass'),
			-- f(function(args) return table.concat(args[1]):gsub('..*', ' ') end, 1),
			c(4, {
				t(''),
				sn(nil, {
					t(' extends '),
					i(1, 'BaseClass'),
				}),
			}),
			c(5, {
				t(''),
				sn(nil, {
					t(' implements '),
					i(1, 'MyInterface'),
					d(2, rec_delim, {}, {
						user_args = { ', ', 'MyInterface' },
					}),
				}),
			}),
			t({ '', '{', '\t' }),
			i(0),
			t({ '', '}' }),
		}),

		s('interface', {
			c(1, {
				t('public '),
				t('private '),
			}),
			c(2, {
				t(''),
				t('static '),
			}),
			t('interface '),
			filename_node(3, 'MyInterface'),
			c(4, {
				t(''),
				sn(nil, {
					t(' extends '),
					i(1, 'MyInterface'),
					d(2, rec_delim, {}, {
						user_args = { ', ', 'MyInterface' },
					}),
				}),
			}),
			t({ '', '{', '\t' }),
			i(0),
			t({ '', '}' }),
		}),

		s('main', {
			t({ 'public static void main(String[] args)', '\t' }),
			i(0),
			t({ '', '}' }),
		}),

		s('method', {
			c(1, {
				t('public'),
				t('protected'),
				t('private'),
			}),
			c(2, {
				t(''),
				t(' static'),
			}),
			t(' '),
			i(3, 'void'),
			t(' '),
			i(4, 'methodName'),
			t('('),
			i(5),
			t({ ')', '{', '\t' }),
			i(0),
			t({ '', '}' }),
		}),

		s('getter', {
			t('public '),
			i(2, 'String'),
			t(' get'),
			d(3, capitalize, { 1 }),
			t({ '()', '{', '\treturn ' }),
			i(1),
			t({ ';', '}' }),
		}),

		s('setter', {
			t({ 'public void set' }),
			d(3, capitalize, { 1 }),
			t('('),
			i(2, 'String'),
			t(' '),
			f(copy, 1),
			t({ ')', '{', '\tthis.' }),
			i(1),
			t(' = '),
			f(copy, 1),
			t({ ';', '}' }),
		}),
	})

	-- }}}
	-- {{{ markdown

	ls.add_snippets('markdown', {
		s('qso', { t('{{% qso '), i(1), t(' %}}') }),
		s('motion', {
			t('{{< motion "'), i(1, "to do ..."), t('" '), i(2, 'mover'), t(' '),
			c(3, {
				t('/>}}'),
				sn(nil, {
					i(1, 'seconder'), t(' "'), i(3, 'outcome'),
					t('" '),
					c(2, {
						t('/>}}'),
						sn(nil, {
							t({'>}}', '\t'}), i(1, 'discussion'), t({'', '{{</ motion >}}'}),
						}),
					}),
				}),
				sn(nil, {
					t({'>}}', '\t'}), i(1, 'discussion'), t({'', '{{</ motion >}}'}),
				}),
			}),
		}),
		s('sup', { t('<sup>'), i(1), t('</sup>') }),
		s('sub', { t('<sub>'), i(1), t('</sub>') }),
		s({
			trig = '#(%d+)',
			name = 'TCAT Gitea Issue Link',
			regTrig = true,
			docTrig = 'Gitea Link',
		}, {
			t('[#'),
			f(function(_, snip)
				return snip.captures[1]
			end),
			t('](https://gitea.citd.tamu.edu/TCAT/'),
			i(1, 'project'),
			t('/issues/'),
			f(function(_, snip)
				return snip.captures[1]
			end),
			t(')'),
		}),
	})

	-- }}}
	-- {{{ php

	ls.add_snippets('php', {
		s('php', t({ '<?php declare(strict_types=1);', '', '' })),

		s('getter', {
			t('public function get'),
			d(3, capitalize, { 1 }),
			t('(): '),
			i(2, '?string'),
			t({ '', '{', '\treturn $this->' }),
			i(1),
			t({ ';', '}' }),
		}),

		s('setter', {
			t('public function set'),
			d(3, capitalize, { 1 }),
			t('('),
			i(2, '?string'),
			t(' $'),
			f(copy, 1),
			t({ '): self', '{', '\t$this->' }),
			i(1),
			t(' = $'),
			f(copy, 1),
			t({ ';', '\treturn $this;', '}' }),
		}),
	})

	-- }}}
	-- {{{ sh

	ls.add_snippets('sh', {
		s('DIR', t({ 'DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"', '' })),
	})

	-- }}}
	-- {{{ tex

	ls.add_snippets('tex', {
		s({ trig = 'e', name = 'TeX Environment' }, {
			t('\\begin{'),
			i(1),
			t('}'),
			t({ '', '\t' }),
			i(0),
			t({ '', '\\end{' }),
			f(copy, 1),
			t('}'),
		}),

		s({ trig = 'item', name = 'Itemized List Item' }, {
			t('\\item '),
			i(1),
			d(2, rec_delim, {}, {
				user_args = { { '', '\\item ' } },
			}),
		}),

		s({ trig = 'f', name = 'Math Fraction' }, { t('\\frac{'), i(1), t('}{'), i(2), t('}') }),
		s({ trig = 'm', name = 'Inline Math' }, { t('\\( '), i(1), t(' \\)') }),
		s({ trig = 'M', name = 'Display Math' }, { t('\\[ '), i(1), t(' \\]') }),
		s({ trig = 't', name = 'Math Text' }, { t('\\text{'), i(1), t('}') }),
		s({ trig = '(', name = 'Matching Parentheses: ()' }, { t('\\left( '), i(1), t(' \\right)') }),
		s({ trig = '[', name = 'Matching Square Brackets: []' }, { t('\\left[ '), i(1), t(' \\right]') }),
		s({ trig = '{', name = 'Matching Curly Braces: {}' }, { t('\\left\\{ '), i(1), t(' \\right\\}') }),
	})

	-- }}}
	-- {{{ xml

	ls.add_snippets('xml', {
		s({ trig = 'trans', name = 'XLIFF Translation Table Entry' }, {
			t('<trans-unit id="'),
			f(function(args)
				return table.concat(args[1]):gsub('%.', '_')
			end, { 1 }),
			t({ '">', '\t<source>' }),
			i(1),
			t({ '</source>', '\t<target>' }),
			i(2),
			t({ '</target>', '</trans-unit>' }),
		}),
	})

	-- }}}

	-- }}}
	-- {{{ filetype extensions

	-- ls.filetype_extend('X', {'Y', 'Z'})
	-- load snippets for 'Y' and 'Z' filetypes when editing 'X' filetype

	ls.filetype_extend('cpp', { 'c' })
	ls.filetype_extend('markdown', { 'tex' })

	-- }}}

	-- stop snippets when leaving insert mode
	-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
	vim.api.nvim_create_autocmd('ModeChanged', {
		pattern = '*',
		callback = function()
			if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
				and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
				and not luasnip.session.jump_active
			then
				luasnip.unlink_current()
			end
		end
	})
end

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

do
	-- extend color palettes
	local colors = require('NeoSolarized.colors')

	colors.dark = vim.tbl_extend('force', {}, colors.dark, {
		diff_text = '#404000',
	})

	colors.light = vim.tbl_extend('force', {}, colors.light, {
		diff_add = '#caffca',
		diff_change = '#ffffca',
		diff_delete = '#ffcaca',
		diff_text = '#e8e8b3',
	})
end

neosolarized.setup({
	-- NOTE: commented options represent default values
	-- style = 'dark',
	-- transparent = true
	transparent = false,
	-- terminal_colors = true,
	-- enable_italics = true,
	-- styles = {
	-- 	comments = { italic = true },
	-- 	keywords = { italic = true },
	-- 	functions = { bold = true },
	-- 	variables = {},
	-- 	string = { italic = true },
	-- 	underline = true,
	-- 	undercurl = true,
	-- },
	on_highlights = function(highlights, colors)
		highlights.ColorColumn.bg = colors.bg1
		highlights.CursorColumn = { link = "CursorLine" }
		highlights.DiffChange.bg = colors.diff_change
		highlights.DiffText.bg = colors.diff_text
	end,
})

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

	dap.configurations.cpp = {
		{
			name = 'Launch file',
			type = 'codelldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}

	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp
end

dap_ui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
	dap_ui.open()
end

dap.listeners.after.event_terminated['dapui_config'] = function()
	dap_ui.close()
end

dap.listeners.after.event_exited['dapui_config'] = function()
	dap_ui.close()
end

-- }}}
-- {{{ nvim-surround

surround.setup()

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
-- {{{ oil

oil.setup()

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

-- {{{ list of installed/recommended language servers

-- ansible-language-server
-- clangd
-- codelldb
-- emmet-language-server
-- grammarly-languageserver
-- intelephense
-- jdtls
-- lemminx
-- lua-language-server
-- prettierd
-- pyright
-- rust-analyzer
-- stylua
-- texlab
-- typescript-language-server

-- }}}

do
	local capabilities = cmp_nvim_lsp.default_capabilities()

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
		bmap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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

	-- }}}

	mason_lspconfig.setup_handlers({
		-- {{{ default settings
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		-- }}}
		clangd = function() -- {{{
			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = vim.tbl_deep_extend('force', capabilities, {
					offsetEncoding = {'utf-16'},
				}),
			})
		end,
		-- }}}
		emmet_ls = function() -- {{{
			lspconfig.emmet_ls.setup({
				on_attach = on_attach,
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
		end,
		-- }}}
		grammarly = function() -- {{{
			lspconfig.grammarly.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { 'n', 'run', '16', vim.fn.stdpath('data') .. '/mason/bin/grammarly-languageserver', '--stdio' },
				filetypes = {
					'*markdown*',
					'*tex*',
				},
				init_options = {
					-- this is set in sysetm.vim from dotter variables in local.toml
					clientId = vim.g.grammarly_client_id,
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
		end,
		-- }}}
		intelephense = function() -- {{{
			lspconfig.intelephense.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				init_options = {
					-- this is set in sysetm.vim from dotter variables in local.toml
					licenseKey = vim.g.intelephense_license_key,
					globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense',
				},
			})
		end,
		-- }}}
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
		end,
		-- }}}
		lua_ls = function() -- {{{
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
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
		end,
		-- }}}
	})
end

-- }}}
-- {{{ syntax highlighting

vim.cmd [[
	try
		colorscheme NeoSolarized
	catch /.*/
		colorscheme default
	endtry
]]

-- force whitespace highlighting to look like comments
vim.cmd([[
	augroup mysyntax
		autocmd! Syntax,BufNewFile,BufReadPost * highlight link Whitespace Comment
	augroup END
]])

-- }}}
-- {{{ file associations

vim.filetype.add({
	extension = {
		cshtml = 'html.cs',
		gabc = 'gabc',
		hujson = 'jsonc',
		njk = 'htmldjango',
	},
	filename = {
		Jenkinsfile = 'groovy',
	},
	pattern = {
		['.*/ansible/.*%.yml'] = 'yaml.ansible',
	},
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
