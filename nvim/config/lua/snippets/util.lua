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

function M.rec_delim(jump_index, delim, placeholder)
	function recurse()
		return sn(
			nil,
			c(1, {
				t(''), -- putting sn(...) first causes infinite loop
				sn(nil, {
					t(delim),
					i(1, placeholder),
					d(2, recurse),
				}),
			})
		)
	end

	return d(jump_index, recurse)
end

-- obtain the visual selection as fixed text if available
-- or act like a placeholder if no visual selection is available
function M.visual(jump_index, placeholder)
	return d(jump_index, function(args, parent, old_state, user_args)
		if #parent.snippet.env.SELECT_RAW > 0 then
			return sn(nil, t(parent.snippet.env.SELECT_RAW))
		else
			return sn(nil, i(1, placeholder))
		end
	end)
end

return M
