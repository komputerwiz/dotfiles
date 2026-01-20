return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			-- automatically install and activate treesitter parsers for supported languages
			vim.api.nvim_create_autocmd({ 'FileType' }, {
				callback = function(event)
					local nvim_treesitter = require('nvim-treesitter')

					-- check whether treesitter parser is available
					local parsers = require('nvim-treesitter.parsers')
					if not parsers[event.match] or not nvim_treesitter.install then
						return
					end

					local filetype = vim.bo[event.buf].filetype
					local language = vim.treesitter.language.get_lang(filetype)
					nvim_treesitter.install({ language }):await(function(err)
						if err then
							vim.notify('Treesitter install error for filetype: ' .. filetype .. ' error: ' .. err)
							return
						end

						pcall(vim.treesitter.start, event.buf)
						vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
						vim.wo.foldmethod = 'expr'
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end)
				end,
			})
		end,
	},
}
