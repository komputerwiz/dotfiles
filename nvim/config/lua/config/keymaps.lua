-- This file is for global keybindings
-- Plugin-specific keybindings are loaded by the corresponding entry for lazy.nvim

local map = vim.keymap.set

map('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>', { desc = 'cd to file'})
map('n', '<Leader>v', '<Cmd>leftabove split ' .. vim.fn.stdpath('config') .. '<CR>', { desc = 'Edit vimrc'})

map('', '<F2>', function() vim.opt.background = vim.o.background == 'dark' and 'light' or 'dark' end, { desc = 'Toggle dark mode' })

map({'n', 'v'}, '<Space>', 'za', { desc = 'Expand fold'})

-- use %% in command mode to insert the directory of the current buffer
map('c', '%%', [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { nowait = true, expr = true })

-- start new undo sequence for <C-u> and <C-w> in insert mode
map('i', '<C-u>', '<C-g>u<C-u>')
map('i', '<C-w>', '<C-g>u<C-w>')

-- GUI keybindings
if vim.g.neovide then
	map({'n', 'v'}, '<C-+>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end, { desc = 'Increase font size' })
	map({'n', 'v'}, '<C-_>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end, { desc = 'Decrease font size' })
	map({'n', 'v'}, '<C-)>', function () vim.g.neovide_scale_factor = 1 end, { desc = 'Reset font size' })
end
