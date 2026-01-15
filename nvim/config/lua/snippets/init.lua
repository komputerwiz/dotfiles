local ls = require('luasnip')
local u = require('snippets.util')

ls.add_snippets('all', require('snippets.all'))
ls.add_snippets('c', require('snippets.c'))
ls.add_snippets('cpp', require('snippets.cpp'))
ls.add_snippets('java', require('snippets.java'))
ls.add_snippets('markdown', require('snippets.markdown'))
ls.add_snippets('php', require('snippets.php'))
ls.add_snippets('sh', require('snippets.sh'))
ls.add_snippets('tex', require('snippets.tex'))
ls.add_snippets('xml', require('snippets.xml'))

-- ls.filetype_extend('X', {'Y', 'Z'})
-- load snippets for 'Y' and 'Z' filetypes when editing 'X' filetype

ls.filetype_extend('cpp', { 'c' })
ls.filetype_extend('markdown', { 'tex' })
