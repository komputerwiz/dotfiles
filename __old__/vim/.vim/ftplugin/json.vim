command! -buffer FormatJSON %!python3 -m json.tool
nmap <buffer> =j :FormatJSON<CR>
