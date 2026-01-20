vim.opt_local.makeprg = 'latexmk -pdf %'

vim.keymap.set({ 'n', 'i' }, '<F5>', '<Esc>:update|make<CR>', { buffer = true, noremap = true, desc = 'Recompile current file' })

-- config for built-in tex ftplugin
vim.g.tex_flavor = 'latex'
