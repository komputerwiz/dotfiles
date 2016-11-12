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
Plugin 'avakhov/vim-yaml', {'name': 'vim-yaml-indent'}
"Plugin 'chikamichi/mediawiki.vim'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'digitaltoad/vim-jade'
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
Plugin 'mattn/emmet-vim'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pangloss/vim-javascript'
"Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'skammer/vim-css-color'
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
set shiftwidth=4                " Soft tabs are 4 spaces wide
set softtabstop=4               " Backspace acts like unindent
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

nnoremap <silent> <Leader>s :set spell!<CR>
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
    set guioptions-=T           " Hide toolbar by default

    " Hide scrollbars by default
    set guioptions-=r           " right scrollbar
    set guioptions-=R           " right scrollbar (vsplit)
    set guioptions-=l           " left scrollbar
    set guioptions-=L           " left scrollbar (vsplit)
    set guioptions-=b           " bottom scrollbar

    " mappings to toggle gui elements
    nnoremap <D-\> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    nnoremap <Leader>R :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
    nnoremap <Leader>L :if &go=~#'l'<Bar>set go-=l<Bar>else<Bar>set go+=l<Bar>endif<CR>
    nnoremap <Leader>B :if &go=~#'b'<Bar>set go-=b<Bar>else<Bar>set go+=b<Bar>endif<CR>
endif


" =========================== "
"  Mappings and Key Bindings  "
" =========================== "

" calculate expressions on C-A
" inoremap <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

nnoremap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader>v :tabedit $MYVIMRC<CR>

" opening and closing folds quickly
nnoremap <silent> <Space> za
vnoremap <silent> <Space> za

" toggle light and dark background
noremap <silent> <F2> :let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>
noremap <silent> <F3> :NERDTreeToggle<CR>
" toggle goyo.vim distraction-free mode
noremap <silent> <F11> :Goyo<CR>

" exchange lines like in eclipse; we do want recursive mapping...
" vim-style up/down
nnoremap <A-k> [e
inoremap <A-k> [e
vnoremap <A-k> [egv
nnoremap <A-j> ]e
inoremap <A-j> ]e
vnoremap <A-j> ]egv

" arrow keys
nnoremap <A-Up> [e
inoremap <A-Up> [e
vnoremap <A-Up> [egv
nnoremap <A-Down> ]e
inoremap <A-Down> ]e
vnoremap <A-Down> ]egv


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


" ==================================== "
"  Autosource vimrc when it's updated  "
" ==================================== "

if has('autocmd')
  autocmd BufWritePost .vimrc source $MYVIMRC
endif


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


" ================================================ "
"  YouCompleteMe / UltiSnips Plugin Configuration  "
" ================================================ "

" tone down identifier autocompletion triggering; I can type fast enough
let g:ycm_min_num_of_chars_for_completion = 5
let g:ycm_min_num_identifier_candidate_chars = 7

" don't show preview YCM window
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" ====================== "
"  Riv Plugin Variables  "
" ====================== "

"let g:riv_default_path = '~'


" ========================= "
"  Ctrl-P Plugin Variables  "
" ========================= "

let g:ctrlp_working_path_mode = 'ra'

" let .project file mark the root of a project directory
let g:ctrlp_root_markers = ['.project']

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', 'find %s -type f']


" ==================================== "
"  Global Vim Configuration Variables  "
" ==================================== "

" prefer LaTeX variant of the TeX grammar
let g:tex_flavor='latex'


" ====================== "
"  Vdebug Configuration  "
" ====================== "

"let g:vdebug_keymap = {
"            \ 'run_to_cursor': '<F8>',
"            \ 'step_into': '<F5>',
"            \ 'step_over': '<F6>',
"            \ 'step_out': '<F7>',
"            \ 'run': '<C-F5>',
"            \ 'close': '<C-F6>',
"            \ 'detach': '<C-F7>',
"            \ 'set_breakpoint': '<C-S-b>',
"            \ 'get_context': '<F11>',
"            \ 'eval_under_cursor': '<F12>',
"            \ 'eval_visual': '<Leader>e',
"            \}
