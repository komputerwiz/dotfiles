local command = vim.api.nvim_create_user_command

-- delete the current file and its buffer (this functionality could be provided by tpope/vim-eunuch)
command('Delete', function(o)
  vim.fn.delete(vim.fn.expand('%:p'))
  vim.cmd('bdelete' .. (o.bang and '!' or ''))
end, {
  bar = true,
  bang = true,
})

-- set tabstop, softtab, and shiftwidth to the same value
command('Stab', function(o)
  local width = tonumber(o.args)
  if width > 0 then
    vim.opt_local.softtabstop = width
    vim.opt_local.tabstop = width
    vim.opt_local.shiftwidth = width
  end
end, { nargs = 1 })

-- simplify colorscheme for non-true-color terminals
command('SimpleColors', function()
  vim.opt.termguicolors = false
  vim.cmd('colorscheme default')
end, {})
