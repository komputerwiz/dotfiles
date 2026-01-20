local ls = require('luasnip')
local u = require('snippets.util')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

return {
	s({ trig = 'trans', name = 'XLIFF Translation Table Entry' }, {
		t('<trans-unit id="'),
		f(function(args)
			return table.concat(args[1]):gsub('%.', '_')
		end, { 1 }),
		t({ '">', '\t<source>' }),
		i(1),
		t({ '</source>', '\t<target>' }),
		i(2),
		t({ '</target>', '</trans-unit>' }),
	}),
}
