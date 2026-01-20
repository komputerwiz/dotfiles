return {
	{
		'L3MON4D3/LuaSnip',
		config = function()
			local ls = require('luasnip')
			local types = require('luasnip.util.types')

			ls.setup({
				history = true,
				updateevents = 'TextChanged,TextChangedI',
				enable_autosnippets = true,
				ext_opts = {
					-- display `snip:choice` at end of line when choice node is active
					[types.choiceNode] = {
						active = {
							virt_text = { { '  <-- snip:choice (<C-e>)', 'Comment' } },
						},
					},
				},
			})

			-- stop snippets when leaving insert mode
			-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
			vim.api.nvim_create_autocmd('ModeChanged', {
				pattern = '*',
				callback = function()
					if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
						and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
						and not ls.session.jump_active
					then
						ls.unlink_current()
					end
				end
			})

			require('snippets')
		end,
	}
}
