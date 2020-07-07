" Load vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  execute '!curl --create-dirs -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'icymind/NeoSolarized'
Plug 'chaoren/vim-wordmotion'
Plug 'chikamichi/mediawiki.vim'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'nblock/vim-dokuwiki', { 'for': 'dokuwiki' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' } "dependency for tsuquyomi
Plug 'sirver/ultisnips' "| Plug 'honza/vim-snippets'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-criticmarkup', { 'for': 'markdown' }
Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }
Plug 'w0rp/ale'
call plug#end()

colorscheme NeoSolarized

set background=dark
set colorcolumn=80,92,100,120
set completeopt=longest,menu
set concealcursor=nc
set conceallevel=2
set expandtab
set hidden
set mouse=a "temporary until neovim default mouse setting is changed
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
set tabstop=8
set termguicolors
set wildmode=longest:full,full

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <Leader>h :Hexmode<CR>
nnoremap <silent> <Leader>o :TagbarToggle<CR>
nnoremap <silent> <Leader>t :Tags<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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

" ======================== "
"  Commands and Functions  "
" ======================== "

" delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
command! -bar -bang Delete call delete(expand('%:p')) | bdelete<bang>

" set tabstop, softtab, and shiftwdth to the same value
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

" =============== "
"  Plugin config  "
" =============== "

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_mode_map = { '__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S' }

" ale
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_error_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'

" dbext (public config; put private config in plugin/dbext.sec.vim)
let g:dbext_default_history_file = '~/.local/share/nvim/dbext_history.txt'

" dokuwiki
let g:dokuwiki_fenced_languages = ['bash=sh', 'javascript', 'php', 'ruby']

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
