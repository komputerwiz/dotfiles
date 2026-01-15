local ls = require('luasnip')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

return {
	-- copies the text value of another text field
	copy = function(args)
		return args[1]
	end,

	-- capitalize the first letter of a word
	capitalize = function(args)
		local capitalized = table.concat(args[1]):gsub('^%l', string.upper)
		return sn(nil, i(1, capitalized))
	end,

	-- recursive delimited expansion
	rec_delim = function(args, parent, old_state, delim, placeholder)
		return sn(
			nil,
			c(1, {
				t(''), -- putting sn(...) first causes infinite loop
				sn(nil, {
					t(delim),
					i(1, placeholder),
					d(2, rec_delim, {}, { user_args = { delim, placeholder } }),
				}),
			})
		)
	end,
}
