local ls = require('luasnip')
local u = require('snippets.util')

ls.add_snippets('all', require('snippets.defs.all'))
ls.add_snippets('c', require('snippets.defs.c'))
ls.add_snippets('cpp', require('snippets.defs.cpp'))
ls.add_snippets('java', require('snippets.defs.java'))
ls.add_snippets('markdown', require('snippets.defs.markdown'))
ls.add_snippets('php', require('snippets.defs.php'))
ls.add_snippets('sh', require('snippets.defs.sh'))
ls.add_snippets('tex', require('snippets.defs.tex'))
ls.add_snippets('xml', require('snippets.defs.xml'))

-- ls.filetype_extend('X', {'Y', 'Z'})
-- load snippets for 'Y' and 'Z' filetypes when editing 'X' filetype

ls.filetype_extend('cpp', { 'c' })
ls.filetype_extend('markdown', { 'tex' })
