if exists('g:did_coc_loaded')
  nmap <silent> gd <Plug>(coc-definition)

  " <C-Space> is treated differently by terminal emulators
  inoremap <silent> <expr> <C-Space> coc#refresh()
  inoremap <silent> <expr> <Nul> coc#refresh()

  nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
  nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

  autocmd CursorHold * silent call CocActionAsync('highlight')
endif
