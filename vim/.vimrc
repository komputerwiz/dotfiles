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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'airblade/gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
call plug#end()

colorscheme solarized

set background=dark
set colorcolumn=80,92,100,120
set expandtab
set hidden
set nowrap
set number
set path+=**
set shiftwidth=2
set softtabstop=2
set spelllang=en_us
set tabstop=8

nnoremap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader>s :set spell!<CR>
nnoremap <silent> <Leader>t :TagbarToggle<CR>

noremap <silent> <F2> :let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>
noremap <silent> <F3> :NERDTreeToggle<CR>

nnoremap <silent> <Space> za
vnoremap <silent> <Space> za

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

map <C-p> :FZF<CR>

" ======================================================= "
"  Set tabstop, softtab, and shiftwdth to the same value  "
" ======================================================= "

command! -nargs=1 Stab call Stab(<f-args>)
function! Stab(width)
    if a:width > 0
        let &l:sts = a:width
        let &l:ts = a:width
        let &l:sw = a:width
    endif
endfunction

" ============= "
"  GUI options  "
" ============= "

if has('gui_macvim')
  set guifont=Ubuntu\ Mono:h9
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
let g:airline_mode_map = { '__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S' }

" editorconfig
let g:EditorConfig_exclude_pattrens = ['fugitive://.*']

" syntastic
function! FindConfig(prefix, what, where)
  " look for config in ancestral directories
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_typescript_checkers = ['tslint']
