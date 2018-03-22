command! FormatJSON %!python -m json.tool
nmap =j :FormatJSON<CR>
