" Build script
setlocal makeprg=latexmk\ \-pdf\ %

" Tab width = 2 spaces
setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Text width = 80 chars
setlocal textwidth=80 colorcolumn=80

" Environment and command macros
nnoremap <Leader>e ByEi\begin{<Esc>Ea}<CR>\end{<Esc>pA}<Esc>k$
nnoremap <Leader>c Bi\<Esc>Ea{}<Esc>h
