local ls = require('luasnip')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local M = {}

-- capitalize the first letter of a word
function M.capitalize(args)
	local capitalized = table.concat(args[1]):gsub('^%l', string.upper)
	return sn(nil, i(1, capitalized))
end

-- copies the text value of another text field
function M.copy(args)
	return args[1]
end

-- recursive delimited expansion
function M.rec_delim(args, parent, old_state, delim, placeholder)
	return sn(
		nil,
		c(1, {
			t(''), -- putting sn(...) first causes infinite loop
			sn(nil, {
				t(delim),
				i(1, placeholder),
				d(2, M.rec_delim, {}, { user_args = { delim, placeholder } }),
			}),
		})
	)
end

-- obtain the visual selection as fixed text if available
-- or act like a placeholder if no visual selection is available
function M.visual(jump_index, placeholder)
	return d(jump_index, function(_, snip)
		if snip.env.SELECT_RAW then
			return sn(nil, { t(snip.env.SELECT_RAW) })
		else
			return sn(nil, { i(1, placeholder)})
		end
	end)
end

return M
