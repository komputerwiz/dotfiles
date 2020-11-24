" neovim-like default options not set by vim-plug or sensible
set belloff=all
set hlsearch
set langnoremap
set nocompatible
set showcmd
set ttyfast

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'chaoren/vim-wordmotion'
Plug 'chikamichi/mediawiki.vim', { 'for': 'mediawiki' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'icymind/NeoSolarized'
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lumiliet/vim-twig', { 'for': '*twig*' }
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'mattn/emmet-vim', { 'for': ['*html*', '*css*'] }
Plug 'nblock/vim-dokuwiki', { 'for': 'dokuwiki' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-criticmarkup', { 'for': 'markdown' }
Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }

if executable('git')
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
endif

if executable('gpg')
  Plug 'jamessan/vim-gnupg'
endif

if executable('node')
  Plug 'leafgarland/typescript-vim', { 'for': '*typescript*' }
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'peitalin/vim-jsx-typescript', { 'for': '*typescript*' }
endif

if has('python') || has('python3')
  Plug 'sirver/ultisnips' "| Plug 'honza/vim-snippets'
endif

"Plug 'dense-analysis/ale'
"if executable('php')
"  Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
"endif
call plug#end()

colorscheme NeoSolarized

set background=dark
set colorcolumn=80,92,100,120
set completeopt=longest,menu
set concealcursor=c
set conceallevel=2
set expandtab
set hidden
set list
set listchars=tab:»\ ,trail:-,nbsp:+
set nojoinspaces
set nowrap
set number
set path+=**
set shiftround
set shiftwidth=2
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set tabstop=2
set wildmode=longest:full,full

" put 'vim turds' in their own directory
" https://www.reddit.com/r/vim/comments/741kjn/apple_commit_in_darwin_xnu_calls_swap_files_vim/
let swap_dir = expand('~/.vim/swapfiles')
if !isdirectory(swap_dir)
  call mkdir(swap_dir)
endif
set directory^=~/.vim/swapfiles/

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <Leader>h :Hexmode<CR>
nnoremap <silent> <Leader>o :TagbarToggle<CR>
nnoremap <silent> <Leader>t :Tags<CR>

noremap <silent> <F2> :let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>
noremap <silent> <F3> :Lexplore<CR>

nnoremap <silent> <Space> za
vnoremap <silent> <Space> za

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" use %% in command mode to insert the directory of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" <C-Space> is treated differently by terminal emulators
inoremap <C-Space> <C-x><C-o>
inoremap <Nul> <C-x><C-o>

map <C-p> :FZF<CR>

" ======================== "
"  Commands and Functions  "
" ======================== "

" delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
command! -bar -bang Delete call delete(expand('%:p')) | bdelete<bang>

" set tabstop, softtab, and shiftwidth to the same value
function! Stab(width)
  if a:width > 0
    let &l:sts = a:width
    let &l:ts = a:width
    let &l:sw = a:width
  endif
endfunction

command! -nargs=1 Stab call Stab(<f-args>)

" load scriptnames into a scratch buffer
command! -nargs=? Scriptnames Scratch scriptnames <f-args>

" ============= "
"  GUI options  "
" ============= "

if has('gui_macvim')
  set guifont=Ubuntu\ Mono:h11
elseif has('gui_running')
  set guifont=Ubuntu\ Mono\ 9
end

if exists('&guioptions')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b
endif

" =============== "
"  Plugin config  "
" =============== "

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Vim mode key:
"   __ = unknown
"   c  = command
"   i  = insert
"   ic = insert (completion)
"   ix = insert (completion)
"   n  = normal
"   ni = insert-normal (i_CTRL-O)
"   no = operator pending
"   R  = replace
"   Rv = virtual replace
"   s  = select
"   S  = select (line)
"   ^S = select (block)
"   t  = terminal
"   v  = visual
"   V  = visual (line)
"   ^V = visual (block)
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'c'  : 'C',
      \ 'i'  : 'I',
      \ 'ic' : 'I',
      \ 'ix' : 'I',
      \ 'n'  : 'N',
      \ 'ni' : 'N',
      \ 'no' : 'N',
      \ 'R'  : 'R',
      \ 'Rv' : 'R',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ 't'  : 'T',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ }

" dbext (public config; put private config in plugin/dbext.sec.vim)
let g:dbext_default_history_file = '~/.vim/dbext_history.txt'

" dokuwiki
let g:dokuwiki_fenced_languages = ['bash=sh', 'javascript', 'php', 'ruby']

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" gnupg
let g:GPGPreferSign = 1
let g:GPGDefaultRecipients = [
      \'Matthew J. Barry <komputerwiz.matt@gmail.com>'
      \]

" netrw (vim's built-in file browser)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" rust (built-in)
let g:rust_conceal = 1
let g:rust_fold = 1

" vim-jsx-typescript
" The following syntax components are forcibly colored by vim-jsx-typescript.
" Here we reset them to their default links in RUNTIME/syntax/*.vim and let
" the user-selected theme handle coloring
hi link xmlEndTag Identifier
hi link tsxCloseString htmlTagName
hi link htmlTag Function
hi link htmlEndTag Identifier
hi link htmlTagName htmlStatement
hi link tsxAttrib htmlArg
"hi link ReactState
"hi link ReactProps
"hi link Events
"hi link ReduxKeywords
"hi link Ethereum
"hi link WebBrowser
"hi link ReactLifeCycleMethods


" ===================== "
"  Syntax Highlighting  "
" ===================== "

hi link Whitespace Comment
