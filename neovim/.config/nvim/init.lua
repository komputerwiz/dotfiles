-- {{{ common vim lua aliases

local cmd = vim.cmd -- execute commands
local fn = vim.fn   -- call functions
local g = vim.g     -- set global variables
local opt = vim.opt -- set options
local function extend(...) return vim.tbl_extend('force', ...) end -- merge option tables

-- }}}
-- {{{ plugins

require('paq')({
  'savq/paq-nvim', -- let paq manage itself
  'airblade/vim-gitgutter',
  'cespare/vim-toml',
  'chaoren/vim-wordmotion',
  'chikamichi/mediawiki.vim',
  'dag/vim-fish',
  'duggiefresh/vim-easydir',
  'editorconfig/editorconfig-vim',
  'freitass/todo.txt-vim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'icymind/NeoSolarized',
  'jamessan/vim-gnupg',
  'jparise/vim-graphql',
  -- {'junegunn/fzf', run = './install --bin'}, 'junegunn/fzf.vim',
  'junegunn/vim-easy-align',
  'kyazdani42/nvim-web-devicons',
  'L3MON4D3/LuaSnip',
  'leafgarland/typescript-vim',
  'lumiliet/vim-twig',
  'mattn/emmet-vim',
  'nblock/vim-dokuwiki',
  'nelstrom/vim-visual-star-search',
  'neoclide/jsonc.vim',
  'neovim/nvim-lspconfig',
  'ntpeters/vim-better-whitespace',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  'peitalin/vim-jsx-typescript',
  'quangnguyen30192/cmp-nvim-tags',
  'saadparwaiz1/cmp_luasnip',
  'simrat39/symbols-outline.nvim',
  'tpope/vim-abolish',
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  {'nvim-treesitter/nvim-treesitter', run = function () cmd 'TSUpdate' end},
  'vim-airline/vim-airline', 'vim-airline/vim-airline-themes',
  'vim-pandoc/vim-criticmarkup',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
})

-- }}}
-- {{{ syntax highlighting

cmd 'colorscheme NeoSolarized'

-- force whitespace highlighting to look like comments
cmd [[
  augroup mysyntax
    autocmd! Syntax,BufNewFile,BufReadPost * highlight link Whitespace Comment
  augroup END
]]

-- }}}
-- {{{ options

opt.background = 'dark'
opt.colorcolumn = {80, 92, 100, 120}
opt.completeopt = {'menu', 'menuone', 'noselect'} -- {'longest', 'menu'}
opt.concealcursor = 'c'
opt.conceallevel = 2
opt.expandtab = true
opt.exrc = true
opt.hidden = true
opt.joinspaces = false
opt.list = true
opt.listchars = {tab='» ', trail='·', nbsp='+'}
opt.mouse = 'a'
opt.number = true
opt.path:append {'**'}
opt.redrawtime = 500
opt.scrolloff = 1
opt.secure = true
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 5
opt.softtabstop = 2
opt.spelllang = 'en_us'
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 1000
opt.wildmode = {'longest:full', 'full'}
opt.wrap = false

-- }}}
-- {{{ key mappings

local opts = {noremap = true, silent = true}
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

map('x', 'ga', '<Plug>(EasyAlign)', {silent = true})
map('n', 'ga', '<Plug>(EasyAlign)', {silent = true})

-- use %% in command mode to insert the directory of the current buffer
map('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], {noremap = true, nowait = true, expr = true})

-- <C-Space> is treated differently by terminal emulators
map('i', '<C-Space>', '<C-x><C-o>', opts)
map('i', '<Nul>', '<C-x><C-o>', opts)

map('n', '<C-p>', '<Cmd>Telescope find_files hidden=true<CR>', opts)

-- start new undo sequence for <C-u> and <C-w> in insert mode
map('i', '<C-u>', '<C-g>u<C-u>', opts)
map('i', '<C-w>', '<C-g>u<C-w>', opts)

-- }}}
-- {{{ commands and functions

-- delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
cmd [[command! -bar -bang Delete call delete(expand('%:p')) | bdelete<bang>]]

-- set tabstop, softtab, and shiftwidth to the same value
function stab(width)
  local width = tonumber(width)
  if width > 0 then
    vim.opt_local.softtabstop = width
    vim.opt_local.tabstop = width
    vim.opt_local.shiftwidth = width
  end
end

cmd [[command! -nargs=1 Stab lua stab(<f-args>)]]

-- load scriptnames into a scratch buffer
cmd [[command! -nargs=? Scriptnames Scratch scriptnames <f-args>]]

-- simplify colorscheme for non-true-color terminals
cmd [[command! SimpleColors set notermguicolors | colorscheme default]]

-- }}}
-- {{{ plugin config

-- {{{ airline

g.airline_left_sep = ''
g.airline_right_sep = ''
g.airline_mode_map = {
  ['__'] = '-',  -- unknown
  ['c' ] = 'C',  -- command
  ['i' ] = 'I',  -- insert
  ['ic'] = 'I',  -- insert (completion)
  ['ix'] = 'I',  -- insert (completion)
  ['n' ] = 'N',  -- normal
  ['ni'] = 'N',  -- insert-normal (i_CTRL-O)
  ['no'] = 'N',  -- operator pending
  ['R' ] = 'R',  -- replace
  ['Rv'] = 'R',  -- virtual replace
  ['s' ] = 'S',  -- select
  ['S' ] = 'S',  -- select (line)
  [''] = 'S',  -- select (block)
  ['t' ] = 'T',  -- terminal
  ['v' ] = 'V',  -- visual
  ['V' ] = 'V',  -- visual (line)
  [''] = 'V',  -- visual (block)
}

-- }}}
-- {{{ dokuwiki

g.dokuwiki_fenced_languages = {'bash=sh', 'javascript', 'php', 'ruby'}

-- }}}
-- {{{ editorconfig
g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- }}}
-- {{{ gnupg

g.GPGPreferSign = 1
g.GPGDefaultRecipients = {
  'Matthew J. Barry <komputerwiz.matt@gmail.com>',
}

-- }}}
-- {{{ luasnip

-- this configuration is too large and complex to fit here and has been broken
-- into a separate file
require('snippets')

-- }}}
-- {{{ markdown (built-in)

g.markdown_folding = 1

-- }}}
-- {{{ mason

require('mason').setup({
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

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_winsize = 25

-- }}}
-- {{{ nvim-cmp

-- from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local luasnip = require('luasnip')
local cmp = require('cmp')

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function (args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping({
      i = function (fallback)
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          cmp.abort()
        end
      end,
      c = cmp.mapping.close(),
    }),

    ['<Tab>'] = cmp.mapping(function (fallback)
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
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function (fallback)
      -- if cmp.visible() then
        -- cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
  }),

  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  }, {
    {name = 'path'},
  }, {
    {name = 'tags'},
    {name = 'buffer'},
  }),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {name = 'buffer'},
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {name = 'path'},
  }, {
    {name = 'cmdline'},
  }),
})

-- }}}
-- {{{ nvim-treesitter

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = {
      'php',  -- breaks indentation
    },
  },
})

-- }}}
-- {{{ rust (built-in)

g.rust_conceal = 1
g.rust_fold = 1

-- }}}
-- {{{ symbols-outline

g.symbols_outline = {
  auto_preview = false,
  symbols = {
    File = {icon = 'file'},
    Module = {icon = 'mod'},
    Namespace = {icon = '∷'},
    Package = {icon = 'pkg'},
    Class = {icon = 'Ϲ'},
    Method = {icon = 'µ'},
    Property = {icon = '+'},
    Field = {icon = '-'},
    Constructor = {icon = '¢'},
    Enum = {icon = 'Ε'},
    Interface = {icon = 'Ι'},
    Function = {icon = 'ƒ'},
    Variable = {icon = 'ν'},
    Constant = {icon = 'π'},
    String = {icon = '$'},
    Number = {icon = '#'},
    Boolean = {icon = '!'},
    Array = {icon = '@'},
    Object = {icon = '⊙'},
    Key = {icon = 'κ'},
    Null = {icon = '∅'},
    EnumMember = {icon = '·'},
    Struct = {icon = '§'},
    Event = {icon = '&'},
    Operator = {icon = '⊕'},
    TypeParameter = {icon = 'Τ'}
  },
}

-- }}}
-- {{{ telescope

local telescope = require('telescope')
telescope.setup({
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
})

telescope.load_extension('file_browser')

-- }}}
-- {{{ tex (built-in)

g.tex_flavor = 'latex'

-- }}}
-- {{{ vim-jsx-typescript

-- The following syntax components are forcibly colored by vim-jsx-typescript.
-- Here we reset them to their default links in RUNTIME/syntax/*.vim and let
-- the user-selected theme handle coloring
cmd [[
  augroup jsxsyntax
    autocmd!
    autocmd Syntax *typescript* highlight link xmlEndTag Identifier
    autocmd Syntax *typescript* highlight link tsxCloseString htmlTagName
    autocmd Syntax *typescript* highlight link htmlTag Function
    autocmd Syntax *typescript* highlight link htmlEndTag Identifier
    autocmd Syntax *typescript* highlight link htmlTagName htmlStatement
    autocmd Syntax *typescript* highlight link tsxAttrib htmlArg
  augroup END
]]
--autocmd Syntax *typescript* highlight link ReactState
--autocmd Syntax *typescript* highlight link ReactProps
--autocmd Syntax *typescript* highlight link Events
--autocmd Syntax *typescript* highlight link ReduxKeywords
--autocmd Syntax *typescript* highlight link Ethereum
--autocmd Syntax *typescript* highlight link WebBrowser
--autocmd Syntax *typescript* highlight link ReactLifeCycleMethods

-- }}}

-- }}}
-- {{{ language server (LSP) config

-- update LSP capabilities with plugin support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('language-servers').setup({
  capabilities = capabilities,
})

-- }}}
-- {{{ automatically source file after editing

cmd [[
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
]]

-- }}}

-- vim: foldmethod=marker foldlevel=0
