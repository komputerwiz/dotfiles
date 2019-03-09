function HugoSlugify(str)
  return substitute(substitute(tolower(a:str), '[-'']\+', '', 'g'), '\W\+', '-', 'g')
endfunction

function MarkdownTOC()
  let @a = ''
  g/^#\+/t.|s/^\(#\+\)\s*/\=repeat('    ',len(submatch(1))-1)/|s/^\s*\zs.\+/\='* ['.submatch(0).'](#'.HugoSlugify(submatch(0)).')'/|d A
  norm ``
  put a
endfunction

command TOC :call MarkdownTOC()
