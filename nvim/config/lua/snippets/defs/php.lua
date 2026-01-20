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
	s({ trig = 'php', name = 'Opening PHP tag with strict_types' }, t({ '<?php declare(strict_types=1);', '', '' })),

	s({ trig = 'getter', name = 'Class property getter' }, {
		t('public function get'),
		d(3, u.capitalize, { 1 }),
		t('(): '),
		i(2, '?string'),
		t({ '', '{', '\treturn $this->' }),
		i(1),
		t({ ';', '}' }),
	}),

	s({ trig = 'setter', name = 'Class property setter' }, {
		t('public function set'),
		d(3, u.capitalize, { 1 }),
		t('('),
		i(2, '?string'),
		t(' $'),
		f(u.copy, 1),
		t({ '): self', '{', '\t$this->' }),
		i(1),
		t(' = $'),
		f(u.copy, 1),
		t({ ';', '\treturn $this;', '}' }),
	}),
}
