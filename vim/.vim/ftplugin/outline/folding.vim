" Utility Functions
" get the number of the next non-blank line
function! NextNotBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~ '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

" return the number of 'shifts' at start of a line
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

" Fold Expression
function! GetOutlineFold(lnum)
    " ignore blank lines
    if getline(a:lnum) =~ '\v^\s*$'
        " take fold level of adjacent lines, whichever is smaller
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNotBlankLine(a:lnum))

    if next_indent <= this_indent
        " group indented lines greedily
        return this_indent
    elseif next_indent > this_indent
        " fold opens at current line
        return '>' . next_indent
    endif
endfunction

" Fold Text
function! GetOutlineText(fdstart, fdend)
    return getline(a:fdstart) . ' (' . (a:fdend - a:fdstart) . ' lines)'
endfunction

" Set folding options
setlocal foldmethod=expr
setlocal foldexpr=GetOutlineFold(v:lnum)
setlocal foldtext=GetOutlineText(v:foldstart,v:foldend)
