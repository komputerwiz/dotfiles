-- common vim aliases
local cmd = vim.cmd -- execute commands
local fn = vim.fn   -- call functions
local g = vim.g     -- set global variables
local opt = vim.opt -- set options
local function extend(...) return vim.tbl_extend('force', ...) end -- merge option tables

-- ------- --
-- plugins --
-- ------- --

require 'paq' {
  'savq/paq-nvim'; -- let paq manage itself
  {'cespare/vim-toml', opt=true};
  'chaoren/vim-wordmotion';
  {'chikamichi/mediawiki.vim', opt=true};
  {'dag/vim-fish', opt=true};
  'duggiefresh/vim-easydir';
  'editorconfig/editorconfig-vim';
  {'freitass/todo.txt-vim', opt=true};
  'icymind/NeoSolarized';
  {'jparise/vim-graphql', opt=true};
  {'junegunn/fzf', run='./install --bin'}; 'junegunn/fzf.vim';
  'junegunn/vim-easy-align';
  {'lumiliet/vim-twig', opt=true};
  {'majutsushi/tagbar'};
  {'mattn/emmet-vim', opt=true};
  {'nblock/vim-dokuwiki', opt=true};
  'nelstrom/vim-visual-star-search';
  {'neoclide/jsonc.vim', opt=true};
  'neovim/nvim-lspconfig';
  'ntpeters/vim-better-whitespace';
  'tpope/vim-abolish';
  'tpope/vim-commentary';
  'tpope/vim-repeat';
  'tpope/vim-sensible';
  'tpope/vim-surround';
  'tpope/vim-unimpaired';
  'vim-airline/vim-airline'; 'vim-airline/vim-airline-themes';
  {'vim-pandoc/vim-criticmarkup', opt=true};
  'airblade/vim-gitgutter';
  'tpope/vim-fugitive';
  'jamessan/vim-gnupg';
  {'leafgarland/typescript-vim', opt=true};
  {'peitalin/vim-jsx-typescript', opt=true};
  'sirver/ultisnips'; -- 'honza/vim-snippets';
}

-- load optional plugins
cmd [[
  augroup paqopt
    autocmd FileType toml         packadd! vim-toml
    autocmd FileType mediawiki    packadd! mediawiki.vim
    autocmd FileType fish         packadd! vim-fish
    autocmd FileType todo         packadd! todo.txt-vim
    autocmd FileType graphql      packadd! vim-graphql
    autocmd FileType *twig*       packadd! vim-twig
    autocmd FileType *html*,*css* packadd! emmet-vim
    autocmd FileType dokuwiki     packadd! vim-dokuwiki
    autocmd FileType jsonc        packadd! jsonc.vim
    autocmd FileType markdown     packadd! vim-criticmarkup
  augroup END
]]

-- ------------------- --
-- syntax highlighting --
-- ------------------- --

cmd 'colorscheme NeoSolarized'
cmd 'hi link Whitespace Comment'

-- ------- --
-- options --
-- ------- --

opt.background = 'dark'
opt.colorcolumn = {80, 92, 100, 120}
opt.completeopt = {'longest', 'menu'}
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
opt.secure = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.spelllang = 'en_us'
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 1000
opt.wildmode = {'longest:full', 'full'}
opt.wrap = false

-- ------------ --
-- key mappings --
-- ------------ --

local opts = {noremap=true, silent=true}
local map = vim.api.nvim_set_keymap

map('n', '<Leader>b', ':Buffers<CR>', opts)
map('n', '<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', opts)
map('n', '<Leader>h', ':Hexmode<CR>', opts)
map('n', '<Leader>o', ':TagbarToggle<CR>', opts)
map('n', '<Leader>t', ':Tags<CR>', opts)
map('n', '<Leader>v', ':leftabove split $MYVIMRC<CR>', opts)

map('', '<F2>', [[:let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>]], opts)
map('', '<F3>', ':Lexplore<CR>', opts)

map('n', '<Space>', 'za', opts)
map('v', '<Space>', 'za', opts)

map('x', 'ga', '<Plug>(EasyAlign)', opts)
map('n', 'ga', '<Plug>(EasyAlign)', opts)

-- use %% in command mode to insert the directory of the current buffer
map('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], extend(opts, {expr=true}))

-- <C-Space> is treated differently by terminal emulators
map('i', '<C-Space>', '<C-x><C-o>', opts)
map('i', '<Nul>', '<C-x><C-o>', opts)

map('n', '<C-p>', ':FZF<CR>', opts)

-- have Y behave more like D
map('n', 'Y', 'y$', opts)

-- ---------------------- --
-- commands and functions --
-- ---------------------- --

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

-- ------------- --
-- plugin config --
-- ------------- --

-- airline
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

-- dokuwiki
g.dokuwiki_fenced_languages = {'bash=sh', 'javascript', 'php', 'ruby'}

-- editorconfig
g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- gnupg
g.GPGPreferSign = 1
g.GPGDefaultRecipients = {
  'Matthew J. Barry <komputerwiz.matt@gmail.com>',
}

-- markdown (built-in)
g.markdown_folding = 1

-- netrw (vim's built-in file browser)
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_winsize = 25

-- rust (built-in)
g.rust_conceal = 1
g.rust_fold = 1

-- UltiSnips
g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsJumpBackwardTrigger = '<s-tab>'

-- vim-jsx-typescript
-- The following syntax components are forcibly colored by vim-jsx-typescript.
-- Here we reset them to their default links in RUNTIME/syntax/*.vim and let
-- the user-selected theme handle coloring
cmd [[
  hi link xmlEndTag Identifier
  hi link tsxCloseString htmlTagName
  hi link htmlTag Function
  hi link htmlEndTag Identifier
  hi link htmlTagName htmlStatement
  hi link tsxAttrib htmlArg
]]
--hi link ReactState
--hi link ReactProps
--hi link Events
--hi link ReduxKeywords
--hi link Ethereum
--hi link WebBrowser
--hi link ReactLifeCycleMethods

-- --------------------------------------- --
-- automatically source file after editing --
-- --------------------------------------- --

cmd [[
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
]]

-- Language Server Config
local nvim_lsp = require('lspconfig')

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function (client, bufnr)
  local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function bopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- enable omni-completion (<C-x><C-o>)
  bopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- mappings (see `:h vim.lsp.*` for docs)
  local opts = { noremap=true, silent=true }
  bmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  bmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  bmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  bmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  bmap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

nvim_lsp.rust_analyzer.setup {on_attach=on_attach}
nvim_lsp.tsserver.setup {on_attach=on_attach}
nvim_lsp.jdtls.setup {on_attach=on_attach, cmd={'jdtls'}}
