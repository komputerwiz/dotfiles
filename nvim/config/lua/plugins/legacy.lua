return {
	{ 'duggiefresh/vim-easydir' },
	{
		'junegunn/vim-easy-align',
		keys = {
			{ 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, remap = true, desc = 'EasyAlign' },
		},
	},
	{ 'nelstrom/vim-visual-star-search' },
	{ 'ntpeters/vim-better-whitespace' },
	{ 'tpope/vim-abolish' },
	{ 'tpope/vim-commentary' },
	{
		'tpope/vim-fugitive',
		cmd = {
			'Git',
			'Gcd', 'Glcd',
			'Ggrep', 'Glgrep',
			'Gclog', 'Gllog',
			'Ge', 'Gedit', 'Gpedit', 'Gsplit', 'Gvsplit', 'Gtabedit', 'Gdrop',
			'Gr', 'Gread',
			'Gdiffsplit', 'Ghdiffsplit', 'Gvdiffsplit',
			'Gw', 'Gwrite', 'Gwq',
			'GRemove', 'GUnlink', 'GDelete',
			'GMove', 'GRename',
			'GBrowse',
		},
		keys = {
			{ '<Leader>gh', '<Cmd>0Gclog<CR>', mode = 'n', desc = 'Open git log in quickfix' },
		},
	},
	{ 'tpope/vim-repeat' },
	{ 'tpope/vim-unimpaired' },

	{ 'dag/vim-fish' },
	{ 'jparise/vim-graphql', ft = 'graphql' },
	{ 'lumiliet/vim-twig', ft = 'twig' },
	{
		'nblock/vim-dokuwiki',
		ft = 'dokuwiki',
		init = function()
			-- Code block syntax highlighting
			vim.g.dokuwiki_fenced_languages = { 'bash=sh', 'javascript', 'php', 'ruby' }
		end,
	},
	{ 'neoclide/jsonc.vim', ft = 'jsonc' },
	{ 'vim-pandoc/vim-criticmarkup', ft = 'markdown' },
}
