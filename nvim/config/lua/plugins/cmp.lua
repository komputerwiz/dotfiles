return {
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
			end

			local function snip_choice_or_abort()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				else
					cmp.abort()
				end
			end


			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping({
						i = snip_choice_or_abort,
						s = snip_choice_or_abort,
						c = cmp.mapping.close(),
					}),

					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() and luasnip.locally_jumpable(1) then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),

					['<Tab>'] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(1) then
							-- give precedence to jumping to locations within a snippet
							luasnip.jump(1)
						elseif cmp.visible() then
							-- cmp.select_next_item() -- use <C-n> instead
							cmp.confirm({ select = true })
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),

					['<S-Tab>'] = cmp.mapping(function(fallback)
						-- if cmp.visible() then
						-- cmp.select_prev_item() -- use <C-p> instead
						-- elseif luasnip.jumpable(-1) then
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),

				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'path' },
				}, {
					{ name = 'buffer' },
					{ name = 'dictionary', keyword_length = 2 },
				}),
			})

			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
				},
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
				}, {
					{ name = 'cmdline' },
				}),
			})

			-- automatically insert `(` after autocompleting a function or method
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
}
