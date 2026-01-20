vim.opt_local.colorcolumn = {72, 79, 100}
vim.opt_local.textwidth = 72

-- don't wrap code automatically
vim.opt_local.formatoptions:remove({ 't' })
-- wrap comments automatically
vim.opt_local.formatoptions:append({ 'c' })

vim.keymap.set({ 'n', 'i' }, '<F5>', '<Esc>:update|!python %<CR>', { buffer = true, noremap = true, desc = 'Run current file' })
