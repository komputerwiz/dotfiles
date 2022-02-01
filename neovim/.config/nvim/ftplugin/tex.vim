setlocal makeprg=latexmk\ -pdf\ %

nnoremap <buffer> <F5> :update\|make
