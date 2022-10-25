" View the output of any ex command in a scratch buffer
" See https://vim.fandom.com/wiki/List_loaded_scripts
function! s:Scratch (command, ...)
  " turn off pager temporarily
  let saveMore = &more
  set nomore

  " execute command, capturing output to 'lines' variable
  redir => lines
  execute a:command
  redir END

  " send <CR> to dismiss output
  call feedkeys("\<CR>")

  " create new window and buffer containing output
  new | setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines

  " only keep lines matching additional pattern argument(s), if provided
  if a:0 > 0
    execute 'vglobal/'.a:1.'/delete'
  endif

  " special case for scriptnames command: remove leading line numbers
  if a:command == 'scriptnames'
    %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
  endif

  " strip empty lines from start and end of file
  silent %substitute/\%^\_s*\n\|\_s*\%$

  " fit new vsplit height to output
  let height = line('$') + 3
  execute 'normal! z'.height."\<cr>"

  " restore pager option
  let &more = saveMore

  0
endfunction

command! -nargs=+ Scratch call <sid>Scratch(<f-args>)
