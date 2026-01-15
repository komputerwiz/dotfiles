return {
	{
		'chrisgrieser/nvim-spider',
		keys = {
			{ 'w', [[<Cmd>lua require('spider').motion('w')<CR>]], mode = {'n', 'o', 'x'}, desc = 'spider-w' },
			{ 'e', [[<Cmd>lua require('spider').motion('e')<CR>]], mode = {'n', 'o', 'x'}, desc = 'spider-e' },
			{ 'b', [[<Cmd>lua require('spider').motion('b')<CR>]], mode = {'n', 'o', 'x'}, desc = 'spider-b' },
			{ 'ge', [[<Cmd>lua require('spider').motion('ge')<CR>]], mode = {'n', 'o', 'x'}, desc = 'spider-ge' },
		},
	},
}
