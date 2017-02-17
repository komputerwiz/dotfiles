set nocompatible                " We're using VIM, not VI


" ========================== "
"  Vundle Bundle Management  "
" ========================== "

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" GitHub-hosted plugins
"Plugin 'JuliaLang/julia-vim'
"Plugin 'Rykka/riv.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ap/vim-css-color'
Plugin 'avakhov/vim-yaml', {'name': 'vim-yaml-indent'}
"Plugin 'chikamichi/mediawiki.vim'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'digitaltoad/vim-jade'
Plugin 'duggiefresh/vim-easydir'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'
Plugin 'evidens/vim-twig'    " note: author says repo is discontinued
"Plugin 'fatih/vim-go'
"Plugin 'flowtype/vim-flow'
Plugin 'godlygeek/tabular'
"Plugin 'groenewege/vim-less'
"Plugin 'hail2u/vim-css3-syntax'
Plugin 'honza/vim-snippets'    " snippets for UltiSnips
Plugin 'jiangmiao/auto-pairs'
"Plugin 'joonty/vdebug'
Plugin 'junegunn/goyo.vim'
"Plugin 'juvenn/mustache.vim'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pangloss/vim-javascript'
"Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'stephpy/vim-yaml', {'name': 'vim-yaml-syntax'}
"Plugin 'ternjs/tern_for_vim'
"Plugin 'terryma/vim-multiple-cursors'    " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'    " also includes SASS/SCSS support
"Plugin 'tpope/vim-markdown'    " included in recent versions of vim
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'vim-syntastic/syntastic'

" vim-scripts hosted plugins
" See http://vim-scripts.org/vim/scripts.html
Plugin 'camelcasemotion'
"Plugin 'ebnf.vim'

call vundle#end()

filetype plugin indent on

" even though this line is in tpope/vim-sensible, this forces a clean syntax
" state when loading
syntax on


" ==================== "
"  Editor Preferences  "
" ==================== "

set background=dark             " lights out, please; don't burn my eyes

set hidden                      " do not bug me about modified buffers

set smartindent                 " Smart-indent
set tabstop=8                   " Tab literals are 8 spaces wide
set shiftwidth=2                " Soft tabs are 2 spaces wide
set softtabstop=2               " Backspace acts like unindent
set expandtab                   " Insert spaces instead of tabs

set mat=2                       " Show matchng delimiter for .2sec

set nowrap                      " do not wrap text in display

set colorcolumn=80,92,100,120   " right margins for common text widths

set number                      " Line numbers
if exists('&rnu')
    set rnu                     " Relative line numbering
endif

set magic                       " Pattern matching with special chars
set hlsearch                    " Highlight search results

set whichwrap+=<,>,h,l

"set autochdir                   " Automatically set browser to working dir
set path+=**                    " search all paths in current directory recursively

set showcmd                     " show partially-entered commands in the status bar

set tags+=.tags,./.tags

" silent! colorscheme komputerwiz
silent! colorscheme solarized

let mapleader = '\'             " already '\' by default, but can't use multichar maps


" ================ "
"  Spell Checking  "
" ================ "

set spelllang=en_us


" ========= "
"  Folding  "
" ========= "

set foldmethod=syntax
set foldcolumn=4
set foldlevelstart=20           " expand 20 levels of folds by default


" ====== "
"  gVim  "
" ====== "

if has ('gui_macvim')
    set guifont=Ubuntu\ Mono:h11
elseif has('gui_running')
    set guifont=Ubuntu\ Mono\ 11
endif

if exists('&guioptions')
    set guioptions-=m           " hide menu by default
    set guioptions-=T           " hide toolbar by default

    " Hide scrollbars by default
    set guioptions-=r           " right scrollbar
    set guioptions-=R           " right scrollbar (vsplit)
    set guioptions-=l           " left scrollbar
    set guioptions-=L           " left scrollbar (vsplit)
    set guioptions-=b           " bottom scrollbar
endif


" =========================== "
"  Mappings and Key Bindings  "
" =========================== "

" calculate expressions on C-A
" inoremap <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" toggle gui elements
if exists('&guioptions')
    " toolbar
    nnoremap <Leader>T :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    " menu
    nnoremap <Leader>M :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
endif

" type '\a' followed by '|', ':', or '=' to tabularze at that char
nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>a, :Tabularize /,\zs<CR>
vnoremap <Leader>a, :Tabularize /,\zs<CR>

" cursor markings
nnoremap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>
" whitespace characters
nnoremap <silent> <Leader>l :set list!<CR>
" spelling
nnoremap <silent> <Leader>s :set spell!<CR>
" tagbar 'minimap'
nnoremap <silent> <Leader>t :TagbarToggle<CR>
" graphical undo
nnoremap <silent> <Leader>u :GundoToggle<CR>
" edit vimrc
nnoremap <silent> <Leader>v :tabedit $MYVIMRC<CR>

" toggle light and dark background
noremap <silent> <F2> :let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>
" file browser
noremap <silent> <F3> :NERDTreeToggle<CR>
" toggle goyo.vim distraction-free mode
noremap <silent> <F11> :Goyo<CR>

" opening and closing folds quickly
nnoremap <silent> <Space> za
vnoremap <silent> <Space> za

" exchange lines like in eclipse
" NOTE: we *do* want recursive mapping so that unimpaired maps get executed
" vim-style up/down
nmap <A-k> [e
imap <A-k> [e
vmap <A-k> [egv
nmap <A-j> ]e
imap <A-j> ]e
vmap <A-j> ]egv

" arrow keys
nmap <A-Up> [e
imap <A-Up> [e
vmap <A-Up> [egv
nmap <A-Down> ]e
imap <A-Down> ]e
vmap <A-Down> ]egv


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


" ========================== "
"  insert current timestamp  "
" ========================== "

iabbrev <expr> dts strftime("%c")


" ======================================== "
"  vim -b : edit binary using xxd-format!  "
" ======================================== "

augroup Binary
    " remove all autocmds for group 'Binary'
    autocmd!

    autocmd BufReadPre  *.bin let &bin=1

    autocmd BufReadPost *.bin if &bin | %!xxd
    autocmd BufReadPost *.bin set ft=xxd | endif

    autocmd BufWritePre *.bin if &bin | %!xxd -r
    autocmd BufWritePre *.bin endif

    autocmd BufWritePost *.bin if &bin | %!xxd
    autocmd BufWritePost *.bin set nomod | endif
augroup END


" ==================================== "
"  Global Vim Configuration Variables  "
" ==================================== "

" prefer LaTeX variant of the TeX grammar
let g:tex_flavor='latex'
