setlocal colorcolumn=72,79,100
setlocal textwidth=72
setlocal formatoptions-=t "do not wrap code automatically
setlocal formatoptions+=c "wrap comments automatically

inoremap <buffer> <F5> <Esc>:update\|!python %<CR>
nnoremap <buffer> <F5> <Esc>:update\|!python %<CR>
