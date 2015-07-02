if !exists(':Tabularize')
    finish " Tabular did not load
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
