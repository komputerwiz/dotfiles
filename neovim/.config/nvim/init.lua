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
  {'junegunn/fzf', run = './install --bin'}, 'junegunn/fzf.vim',
  'junegunn/vim-easy-align',
  'L3MON4D3/LuaSnip',
  'leafgarland/typescript-vim',
  'lumiliet/vim-twig',
  'mattn/emmet-vim',
  'nblock/vim-dokuwiki',
  'nelstrom/vim-visual-star-search',
  'neoclide/jsonc.vim',
  'neovim/nvim-lspconfig',
  'ntpeters/vim-better-whitespace',
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
  'williamboman/nvim-lsp-installer',
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

map('n', '<Leader>b', ':Buffers<CR>', opts)
map('n', '<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', opts)
map('n', '<Leader>h', ':Hexmode<CR>', opts)
map('n', '<Leader>o', ':SymbolsOutline<CR>', opts)
map('n', '<Leader>v', ':leftabove split $MYVIMRC<CR>', opts)

map('', '<F2>', [[:let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>]], opts)
map('', '<F3>', ':Lexplore<CR>', opts)

map('n', '<Space>', 'za', opts)
map('v', '<Space>', 'za', opts)

map('x', 'ga', '<Plug>(EasyAlign)', {silent = true})
map('n', 'ga', '<Plug>(EasyAlign)', {silent = true})

-- use %% in command mode to insert the directory of the current buffer
map('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], {noremap = true, nowait = true, expr = true})

-- <C-Space> is treated differently by terminal emulators
map('i', '<C-Space>', '<C-x><C-o>', opts)
map('i', '<Nul>', '<C-x><C-o>', opts)

map('n', '<C-p>', ':FZF<CR>', opts)

-- start new undo sequence for <C-u> and <C-w> in insert mode
map('i', '<C-u>', '<C-g>u<C-u>', opts)
map('i', '<C-w>', '<C-g>u<C-w>', opts)

-- }}}
-- {{{ commands and functions

-- delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
cmd [[command! -bar -bang Delete call delete(expand('%:p')) | bdelete<bang>]]

-- set tabstop, softtab, and shiftwidth to the same value
function stab(width)
  width = tonumber(width)
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

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function bopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- enable omni-completion (<C-x><C-o>)
  bopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- {{{ key mappings

  -- (see `:h vim.lsp.*` for docs)
  local opts = {noremap = true, silent = true}

  -- {{{ code navigation

  bmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap('n', 'g]', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- }}}
  -- {{{ inline help

  bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- }}}
  -- {{{ workspace management

  bmap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- }}}
  -- {{{ code manipulation

  bmap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap('n', '<Leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- }}}
  -- {{{ diagnostics

  bmap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  bmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  bmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  bmap('n', '<Leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

  -- }}}

  -- }}}

  cmd [[
    augroup lspconfig
      autocmd!
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      autocmd Syntax * highlight link LspReferenceText CursorLine
      autocmd Syntax * highlight link LspReferenceRead LspReferenceText
      autocmd Syntax * highlight link LspReferenceWrite LspReferenceText
    augroup END
  ]]
end

local lsp_installer = require('nvim-lsp-installer')

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = '●',
      server_pending = '◑',
      server_uninstalled = '○',
    },
  },
})

server_opts = {
  -- define custom server config here
}

-- jdtls workspace
if not vim.env.WORKSPACE then
  vim.env.WORKSPACE = vim.env.HOME .. '/ws/jdtls'
end

-- decorate LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lsp_installer.on_server_ready(function (server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server_opts[server.name] then
    extend(opts, server_opts[server.name])
  end

  server:setup(opts)
end)

-- local nvim_lsp = require('lspconfig')
-- nvim_lsp.clangd.setup {on_attach = on_attach}
-- nvim_lsp.rust_analyzer.setup {on_attach = on_attach}
-- nvim_lsp.tsserver.setup {on_attach = on_attach}
-- nvim_lsp.jdtls.setup {on_attach = on_attach, cmd = {'jdtls'}}
-- nvim_lsp.phpactor.setup {on_attach = on_attach}

-- }}}
-- {{{ automatically source file after editing

cmd [[
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
]]

-- }}}

-- vim: foldmethod=marker foldlevel=0
