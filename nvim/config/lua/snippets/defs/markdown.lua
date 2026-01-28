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
	-- ham radio notes/minutes

	s({ trig = 'qrz', name = 'Link to QRZ profile' }, {
		t('['), i(2, 'Good on QRZ'), t('](https://qrz.com/db/'), u.visual(1, 'n0call'), t(')'),
	}),

	s({ trig = 'qso', name = 'Contact shortcode' }, {
		t('{{% qso '), u.visual(1), t(' %}}'),
	}),

	s({
		trig = 'motion',
		name = 'Motion shortcode',
		desc = 'motion, mover, seconder, discussion, and outcome',
	}, {
		t('{{< motion "'), i(1, "to do ..."), t('" '), i(2, 'mover'), t(' '),
		c(3, {
			sn(nil, {
				i(1, 'seconder'), t(' "'), i(3, 'outcome'),
				t('" '),
				c(2, {
					t('/>}}'),
					sn(nil, {
						t({'>}}', '\t'}), i(1, 'discussion'), t({'', '{{</ motion >}}'}),
					}),
				}),
			}),
			t('/>}}'),
			sn(nil, {
				t({'>}}', '\t'}), i(1, 'discussion'), t({'', '{{</ motion >}}'}),
			}),
		}),
	}),

	-- hugo shortcodes

	s({ trig = 'rref', name = 'Relative reference link' }, {
		t('['), u.visual(1, 'text'), t(']({{< relref "'), i(2, 'href'), t('" >}})'),
	}),

	-- tags

	s({ trig = 'sup', name = 'Superscript tag' }, {
		t('<sup>'), u.visual(1), t('</sup>'),
	}),

	s({ trig = 'sub', name = 'Subscript tag' }, {
		t('<sub>'), u.visual(1), t('</sub>'),
	}),

	-- issue links for work notes

	s({
		trig = 'gh#(%d+)',
		name = 'GitHub Issue Link',
		regTrig = true,
		docTrig = 'GitHub Link',
	}, {
		t('[#'),
		f(function(_, snip)
			return snip.captures and snip.captures[1] or ''
		end),
		t('](https://github.com/'),
		i(1, 'user'),
		t('/'),
		i(2, 'repo'),
		t('/issues/'),
		f(function(_, snip)
			return snip.captures and snip.captures[1] or ''
		end),
		t(')'),
	}),

	s({
		trig = 'gt#(%d+)',
		name = 'TCAT Gitea Issue Link',
		regTrig = true,
		docTrig = 'Gitea Link',
	}, {
		t('[#'),
		f(function(_, snip)
			return snip.captures and snip.captures[1] or ''
		end),
		t('](https://gitea.citd.tamu.edu/TCAT/'),
		i(1, 'project'),
		t('/issues/'),
		f(function(_, snip)
			return snip.captures and snip.captures[1] or ''
		end),
		t(')'),
	}),
}
