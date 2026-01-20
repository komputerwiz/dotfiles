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
	s({
		trig = 'ro5',
		wordTrig = false,
		name = 'Rule of 5',
		dscr = 'Member functions on a class or struct whose definitions '
				.. 'should be defined together: copy/move constructors, copy/move '
				.. 'assignment operators, and destructor',
	}, {
		i(1),
		t('('),
		f(u.copy, 1),
		t({ ' const&) = default;', '' }),
		f(u.copy, 1),
		t('('),
		f(u.copy, 1),
		t({ '&&) noexcept = default;', '' }),
		f(u.copy, 1),
		t('& operator=('),
		f(u.copy, 1),
		t({ ' const&) = default;', '' }),
		f(u.copy, 1),
		t('& operator=('),
		f(u.copy, 1),
		t({ '&&) noexcept = default;', '' }),
		t('~'),
		f(u.copy, 1),
		t({ '() = default;', '' }),
	}),
}
