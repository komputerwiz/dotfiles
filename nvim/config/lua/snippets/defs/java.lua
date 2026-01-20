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

local function filename_node(num, placeholder)
	return d(num, function()
		local classname = vim.fn.expand('%:t:r')
		if classname == '' then
			-- fallback for placeholder text
			classname = placeholder or 'MyType'
		end
		return sn(nil, i(1, classname))
	end)
end

return {
	s({ trig = 'logger', name = 'System Logger for class' }, {
		t('private static final Logger logger = System.getLogger('),
		filename_node(1),
		t('.class.getName());'),
	}),

	s({ trig = 'fori', name = 'for (i)' }, {
		t('for (int '),
		i(1, 'i'),
		t(' = 0; '),
		f(u.copy, 1),
		t(' < '),
		i(2, 'max'),
		t('; '),
		f(u.copy, 1),
		t('++)'),
	}),

	s({ trig = 'fore', name = 'for (each)' }, {
		t('for (var '),
		i(1, 'item'),
		t(' : '),
		i(2, 'collection'),
		t(')'),
	}),

	s('class', {
		c(1, {
			t('public '),
			t('private '),
		}),
		c(2, {
			t(''),
			t('static '),
		}),
		t('class '),
		filename_node(3, 'MyClass'),
		-- f(function(args) return table.concat(args[1]):gsub('..*', ' ') end, 1),
		c(4, {
			t(''),
			sn(nil, {
				t(' extends '),
				i(1, 'BaseClass'),
			}),
		}),
		c(5, {
			t(''),
			sn(nil, {
				t(' implements '),
				i(1, 'MyInterface'),
				d(2, u.rec_delim, {}, {
					user_args = { ', ', 'MyInterface' },
				}),
			}),
		}),
		t({ '', '{', '\t' }),
		i(0),
		t({ '', '}' }),
	}),

	s('interface', {
		c(1, {
			t('public '),
			t('private '),
		}),
		c(2, {
			t(''),
			t('static '),
		}),
		t('interface '),
		filename_node(3, 'MyInterface'),
		c(4, {
			t(''),
			sn(nil, {
				t(' extends '),
				i(1, 'MyInterface'),
				d(2, u.rec_delim, {}, {
					user_args = { ', ', 'MyInterface' },
				}),
			}),
		}),
		t({ '', '{', '\t' }),
		i(0),
		t({ '', '}' }),
	}),

	s('main', {
		t({ 'public static void main(String[] args)', '\t' }),
		i(0),
		t({ '', '}' }),
	}),

	s('method', {
		c(1, {
			t('public'),
			t('protected'),
			t('private'),
		}),
		c(2, {
			t(''),
			t(' static'),
		}),
		t(' '),
		i(3, 'void'),
		t(' '),
		i(4, 'methodName'),
		t('('),
		i(5),
		t({ ')', '{', '\t' }),
		i(0),
		t({ '', '}' }),
	}),

	s('getter', {
		t('public '),
		i(2, 'String'),
		t(' get'),
		d(3, u.capitalize, { 1 }),
		t({ '()', '{', '\treturn ' }),
		i(1),
		t({ ';', '}' }),
	}),

	s('setter', {
		t({ 'public void set' }),
		d(3, u.capitalize, { 1 }),
		t('('),
		i(2, 'String'),
		t(' '),
		f(u.copy, 1),
		t({ ')', '{', '\tthis.' }),
		i(1),
		t(' = '),
		f(u.copy, 1),
		t({ ';', '}' }),
	}),
}
