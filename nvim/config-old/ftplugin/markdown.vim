function! HugoSlugify(str)
  return substitute(substitute(tolower(a:str), '[-'']\+', '', 'g'), '\W\+', '-', 'g')
endfunction

function! MarkdownTOC(...) range
  if a:0 > 0
    let depth = a:1
  else
    let depth = ''
  end

  " save register and current view state
  let savereg = @a

  " clear register (using inserts an extra empty line)
  call setreg('a', [])

  " MAGIC!
  silent! execute
        \ a:firstline.','.a:lastline.'g/^#\{1,'.depth.'\}[^#]/t. |
        \ s/^\(#\+\)\s*/\=repeat(''    '',len(submatch(1))-1)/ |
        \ s/^\s*\zs.\+/\=''* [''.submatch(0).''](#''.HugoSlugify(submatch(0)).'')''/ |
        \ d A'

  " restore editor view and cursor position
  call winrestview(b:winview)

  " paste TOC one line above prev cursor position
  -1put a

  " restore register contents
  let @a = savereg
endfunction

command! -buffer -nargs=? -range=% TOC
      \ let b:winview = winsaveview() |
      \ <line1>,<line2>call MarkdownTOC(<f-args>) |
      \ unlet b:winview
