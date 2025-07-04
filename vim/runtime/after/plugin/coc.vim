if exists('g:did_coc_loaded')
  nnoremap <silent> gd <Plug>(coc-definition)

  " <C-Space> is treated differently by terminal emulators
  inoremap <silent> <expr> <C-Space> coc#refresh()
  inoremap <silent> <expr> <Nul> coc#refresh()

  nnoremap <silent> <Leader>i :call CocActionAsync('doHover')<CR>

  nnoremap <silent> <C-k> <Plug>(coc-diagnostic-prev)
  nnoremap <silent> <C-j> <Plug>(coc-diagnostic-next)

  autocmd CursorHold * silent call CocActionAsync('highlight')
endif
