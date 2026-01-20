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
	s({ trig = 'e', name = 'TeX Environment' }, {
		t('\\begin{'),
		i(1),
		t('}'),
		t({ '', '\t' }),
		i(0),
		t({ '', '\\end{' }),
		f(u.copy, 1),
		t('}'),
	}),

	s({ trig = 'item', name = 'Itemized List Item' }, {
		t('\\item '),
		i(1),
		d(2, u.rec_delim, {}, {
			user_args = { { '', '\\item ' } },
		}),
	}),

	s({ trig = 'f', name = 'Math Fraction' }, { t('\\frac{'), i(1), t('}{'), i(2), t('}') }),
	s({ trig = 'm', name = 'Inline Math' }, { t('\\( '), i(1), t(' \\)') }),
	s({ trig = 'M', name = 'Display Math' }, { t('\\[ '), i(1), t(' \\]') }),
	s({ trig = 't', name = 'Math Text' }, { t('\\text{'), i(1), t('}') }),
	s({ trig = '(', name = 'Matching Parentheses: ()' }, { t('\\left( '), i(1), t(' \\right)') }),
	s({ trig = '[', name = 'Matching Square Brackets: []' }, { t('\\left[ '), i(1), t(' \\right]') }),
	s({ trig = '{', name = 'Matching Curly Braces: {}' }, { t('\\left\\{ '), i(1), t(' \\right\\}') }),
}
