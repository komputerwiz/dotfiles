command! -buffer FormatJSON %!python -m json.tool
nmap <buffer> =j :FormatJSON<CR>
