-- This file is for global keybindings
-- Plugin-specific keybindings are loaded by the corresponding entry for lazy.nvim

vim.keymap.set('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>', { desc = 'cd to file'})
vim.keymap.set('n', '<Leader>v', '<Cmd>leftabove split $MYVIMRC<CR>', { desc = 'Edit vimrc'})

vim.keymap.set('', '<F2>', function() vim.opt.background = vim.o.background == 'dark' and 'light' or 'dark' end, { desc = 'Toggle dark mode' })

vim.keymap.set({'n', 'v'}, '<Space>', 'za', { desc = 'Expand fold'})

-- use %% in command mode to insert the directory of the current buffer
vim.keymap.set('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { nowait = true, expr = true })

-- start new undo sequence for <C-u> and <C-w> in insert mode
vim.keymap.set('i', '<C-u>', '<C-g>u<C-u>')
vim.keymap.set('i', '<C-w>', '<C-g>u<C-w>')

-- GUI keybindings
if vim.g.neovide then
	vim.keymap.set({'n', 'v'}, '<C-+>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end, { desc = 'Increase font size' })
	vim.keymap.set({'n', 'v'}, '<C-_>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end, { desc = 'Decrease font size' })
	vim.keymap.set({'n', 'v'}, '<C-)>', function () vim.g.neovide_scale_factor = 1 end, { desc = 'Reset font size' })
end
