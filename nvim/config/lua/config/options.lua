local g = vim.g
local opt = vim.opt

g.mapleader = '\\'
g.maplocalleader = '_'

if g.neovide then
	opt.guifont = 'Iosevka Nerd Font:h12'
	g.neovide_scale_factor = 1.0
	g.neovide_opacity = 1.0
	g.neovide_floating_blur_amount_x = 3.0
	g.neovide_floating_blur_amount_y = 3.0
	g.neovide_remember_window_size = true
end

opt.background = 'dark'
opt.colorcolumn = { 80, 92, 100, 120 }
opt.completeopt = { 'menu', 'menuone', 'noselect' } -- {'longest', 'menu'}
opt.concealcursor = 'c'
opt.conceallevel = 0
opt.expandtab = false
opt.exrc = true
opt.foldlevel = 99
opt.hidden = true
opt.joinspaces = false
opt.list = true
opt.listchars = {
	tab = '» ',
	lead = '·',
	trail = '·',
	nbsp = '␣',
	precedes = '⟨',
	extends = '⟩',
}
opt.mouse = 'a'
opt.number = true
opt.path:append({ '**' })
opt.redrawtime = 500
opt.scrolloff = 1
opt.secure = true
opt.shiftround = true
opt.shiftwidth = 2
opt.showbreak = '↪ '
opt.sidescrolloff = 5
opt.softtabstop = 2
opt.spelllang = 'en_us'
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 1000
opt.wildmode = { 'longest:full', 'full' }
opt.wrap = false
