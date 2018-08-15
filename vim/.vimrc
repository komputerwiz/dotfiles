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
Plug 'airblade/vim-gitgutter'
Plug 'icymind/NeoSolarized'
Plug 'chaoren/vim-wordmotion'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }
Plug 'w0rp/ale'
call plug#end()

colorscheme NeoSolarized

set background=dark
set colorcolumn=80,92,100,120
set completeopt=longest,menu
set expandtab
set hidden
set nojoinspaces
set nowrap
set number
set path+=**
set shiftwidth=2
set softtabstop=2
set spelllang=en_us
set tabstop=8
set wildmode=longest:full,full

" put 'vim turds' in their own directory
" https://www.reddit.com/r/vim/comments/741kjn/apple_commit_in_darwin_xnu_calls_swap_files_vim/
let swap_dir = expand('~/.vim/swapfiles')
if !isdirectory(swap_dir)
  call mkdir(swap_dir)
endif
set directory^=~/.vim/swapfiles//

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <Leader>g :Gstatus<CR>
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

inoremap <C-Space> <C-x><C-o>
" <C-Space> is treated differently by terminal emulators
inoremap <Nul> <C-x><C-o>

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
let g:airline_mode_map = { '__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S' }

" editorconfig
let g:EditorConfig_exclude_pattrens = ['fugitive://.*']

" gnupg
let g:GPGPreferSign = 1
let g:GPGDefaultRecipients = [
      \'Matthew J. Barry <komputerwiz.matt@gmail.com>'
      \]

" netrw (vim's built-in file browser)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" tsuquyomi
let g:tsuquyomi_disable_quickfix = 1

" vim-jsx-typescript
hi link xmlTagName Function
hi link xmlTag Function
hi link xmlEndTag Function
hi link jsxCloseString Function
