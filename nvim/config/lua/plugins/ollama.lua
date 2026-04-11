return {
	'nomnivore/ollama.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},

	cmd = {
		'Ollama',
		'OllamaModel',
		'OllamaServe',
		'OllamaServeStop',
	},

	keys = {
		-- NOTE: <C-u> is important for selections to work properly
		{ '<LocalLeader>oo', ":<C-u>lua require('ollama').prompt()<CR>", mode = { 'n', 'v' }, desc = 'Ollama prompt' },
		{ '<LocalLeader>og', ":<C-u>lua require('ollama').prompt('Generate_Code')<CR>", mode = { 'n', 'v' }, desc = 'Ollama generate code' },
	},

	--@type Ollama.Config
	opts = {
		model = 'lfm2',
		-- url = 'http://127.0.0.1:11434',
		-- serve = {
		--	on_start = false,
		--	command = 'ollama',
		--	args = { 'serve' },
		--	stop_command = 'pkill',
		--	stop_args = { '-SIGTERM', 'ollama' },
		-- }
	},
}
