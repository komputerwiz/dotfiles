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
	s({ trig = '^#!', name = 'Shebang', trigEngine = 'pattern', snippetType = 'autosnippet' }, {
		t('#!'),
		c(1, {
			sn(nil, {
				t('/usr/bin/env '),
				i(1, 'bash'),
			}),
			i(1, '/bin/bash'),
		}),
		t({'', ''}),
	}),

	s({ trig = 'DIR', name = 'Script directory' }, {
		t({ 'DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"', '' }),
	}),
}
