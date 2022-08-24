local ls = require('luasnip')

-- {{{ shorthand variables

local types = require('luasnip.util.types')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- }}}
-- {{{ luasnip configuration

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  -- enable_autosnippets = true,
  ext_opts = {
    -- display `snip:choice` at end of line when choice node is active
    [types.choiceNode] = {
      active = {
        virt_text = {{'snip:choice', 'Comment'}},
      },
    },
  },
})

-- }}}
-- {{{ helper functions

-- copies the text value of another text field
local function copy(args)
  return args[1]
end

-- traditional functional map operation
local function map(tbl, fn)
  local rv = {}
  for key, val in pairs(tbl) do
    rv[key] = fn(val)
  end
  return rv
end

-- capitalize the first letter of a word
local function capitalize(args)
  local capitalized = table.concat(args[1]):gsub('^%l', string.upper)
  return sn(nil, i(1, capitalized))
end

-- generates a new random v4 UUID
local function uuid4()
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return template:gsub('[xy]', function (c)
    local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
    return string.format('%x', v)
  end)
end

local function filename_node(num, placeholder)
  return d(num, function ()
    local classname = vim.fn.expand('%:t:r')
    if classname == '' then
      -- fallback for placeholder text
      classname = placeholder or 'MyType'
    end
    return sn(nil, i(1, classname))
  end)
end

-- recursive delimited expansion
local function rec_delim(args, parent, old_state, delim, placeholder)
  return sn(nil, c(1, {
    t(''), -- putting sn(...) first causes infinite loop
    sn(nil, {
      t(delim),
      i(1, placeholder),
      d(2, rec_delim, {}, delim, placeholder)
    }),
  }))
end

-- }}}
-- {{{ snippet definitions

-- {{{ global snippets

ls.add_snippets('all', {
  s({trig='date', name='ISO 8601 Date'}, f(function () return os.date('%F') end)),
  s({trig='time', name='ISO 8601 Time'}, f(function () return os.date('%T') end)),
  s({trig='timetz', name='ISO 8601 Time with Timezone Offset'}, f(function () return os.date('%T%z') end)),
  s({trig='datetime', name='ISO 8601 Date and Time'}, f(function () return os.date('%F %T') end)),
  s({trig='datetimetz', name='ISO 8601 Date and Time with Timezone Offset'}, f(function () return os.date('%F %T%z') end)),
  s('shrug', t('¯\\_(ツ)_/¯')),
  s({trig='uuid', name='Random UUIDv4'}, f(uuid4)),
})

-- }}}
-- {{{ c

ls.add_snippets('c', {
  s({trig='ifnd', name='#ifndef Header Guard'}, {
    t('#ifndef '),
    i(1),
    t({'', '#define '}),
    f(copy, 1),
    t({'', '', ''}),
    i(0),
    t({'', '', ''}),
    t('#endif // '), f(copy, 1),
  }),
})

-- }}}
-- {{{ cpp

ls.add_snippets('cpp', {
  s(
    {
      trig = 'ro5',
      wordTrig = false,
      name = 'Rule of 5',
      dscr = 'Member functions on a class or struct whose definitions \z
        should be defined together: copy/move constructors, copy/move \z
        assignment operators, and destructor',
    }, {
      i(1), t('('), f(copy, 1), t({' const&) = default;', ''}),
      f(copy, 1), t('('), f(copy, 1), t({'&&) noexcept = default;', ''}),
      f(copy, 1), t('& operator=('), f(copy, 1), t({' const&) = default;', ''}),
      f(copy, 1), t('& operator=('), f(copy, 1), t({'&&) noexcept = default;', ''}),
      t('~'), f(copy, 1), t({'() = default;', ''}),
    }
  ),
})

-- }}}
-- {{{ java

ls.add_snippets('java', {
  s({trig='logger', name='System Logger for class'}, {
    t('private static final Logger logger = System.getLogger('),
    filename_node(1),
    t('.class.getName());'),
  }),

  s({trig='fori', name='for (i)'}, {
    t('for (int '),
    i(1, 'i'),
    t(' = 0; '),
    f(copy, 1),
    t(' < '),
    i(2, 'max'),
    t('; '),
    f(copy, 1),
    t('++)'),
  }),

  s({trig='fore', name='for (each)'}, {
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
    -- f(function (args) return table.concat(args[1]):gsub('..*', ' ') end, 1),
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
        d(2, rec_delim, {}, ', ', 'MyInterface'),
      }),
    }),
    t({'', '{', '\t'}),
    i(0),
    t({'', '}'}),
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
        d(2, rec_delim, {}, ', ', 'MyInterface'),
      }),
    }),
    t({'', '{', '\t'}),
    i(0),
    t({'', '}'}),
  }),

  s('main', {
    t({'public static void main(String[] args)', '\t'}),
    i(0),
    t({'', '}'}),
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
    t({')', '{', '\t'}),
    i(0),
    t({'', '}'}),
  }),

  s('getter', {
    t('public '),
    i(2, 'String'),
    t(' get'),
    d(3, capitalize, {1}),
    t({'()', '{', '\treturn '}),
    i(1),
    t({';', '}'}),
  }),

  s('setter', {
    t({'public void set'}),
    d(3, capitalize, {1}),
    t('('),
    i(2, 'String'),
    t(' '),
    f(copy, 1),
    t({')', '{', '\tthis.'}),
    i(1),
    t(' = '),
    f(copy, 1),
    t({';', '}'}),
  }),
})

-- }}}
-- {{{ markdown

ls.add_snippets('markdown', {
  s('qso', {t('{{% qso '), i(1), t(' %}}')}),
  s('sup', {t('<sup>'), i(1), t('</sup>')}),
  s('sub', {t('<sub>'), i(1), t('</sub>')}),
  s(
    {
      trig = '#(%d+)',
      name = 'TCAT Gitea Issue Link',
      regTrig = true,
      docTrig = 'Gitea Link',
    },
    {
      t('[#'),
      f(function (_, snip) return snip.captures[1] end),
      t('](https://gitea.citd.tamu.edu/TCAT/'),
      i(1, 'project'),
      t('/issues/'),
      f(function (_, snip) return snip.captures[1] end),
      t(')'),
    }
  ),
})

-- }}}
-- {{{ php

ls.add_snippets('php', {
  s('php', t({'<?php declare(strict_types=1);', '', ''})),

  s('getter', {
    t('public function get'),
    d(3, capitalize, {1}),
    t('(): '),
    i(2, '?string'),
    t({'', '{', '\treturn $this->'}),
    i(1),
    t({';', '}'}),
  }),

  s('setter', {
    t('public function set'),
    d(3, capitalize, {1}),
    t('('),
    i(2, '?string'),
    t(' $'),
    f(copy, 1),
    t({'): self', '{', '\t$this->'}),
    i(1),
    t(' = $'),
    f(copy, 1),
    t({';', '\treturn $this;', '}'}),
  }),
})

-- }}}
-- {{{ sh

ls.add_snippets('sh', {
  s('DIR', t({'DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"', ''})),
})

-- }}}
-- {{{ tex

ls.add_snippets('tex', {
  s({trig='e', name='TeX Environment'}, {
    t('\\begin{'),
    i(1),
    t('}'),
    t({'', '\t'}),
    i(0),
    t({'', '\\end{'}),
    f(copy, 1),
    t('}'),
  }),

  s({trig='item', name='Itemized List Item'}, {
    t('\\item '),
    i(1),
    d(2, rec_delim, {}, {'', '\\item '})
  }),

  s({trig='f', name='Math Fraction'}, { t('\\frac{'), i(1), t('}{'), i(2), t('}') }),
  s({trig='m', name='Inline Math'}, { t('\\( '), i(1), t(' \\)') }),
  s({trig='M', name='Display Math'}, { t('\\[ '), i(1), t(' \\]') }),
  s({trig='t', name='Math Text'}, { t('\\text{'), i(1), t('}') }),
  s({trig='(', name='Matching Parentheses: ()'}, { t('\\left( '), i(1), t(' \\right)') }),
  s({trig='[', name='Matching Square Brackets: []'}, { t('\\left[ '), i(1), t(' \\right]') }),
  s({trig='{', name='Matching Curly Braces: {}'}, { t('\\left\\{ '), i(1), t(' \\right\\}') }),
})

-- }}}
-- {{{ xml

ls.add_snippets('xml', {
  s({trig='trans', name='XLIFF Translation Table Entry'}, {
    t('<trans-unit id="'),
    f(function (args) return table.concat(args[1]):gsub('%.', '_') end, {1}),
    t({'">','\t<source>'}),
    i(1),
    t({'</source>', '\t<target>'}),
    i(2),
    t({'</target>', '</trans-unit>'}),
  }),
})

-- }}}

-- }}}
-- {{{ filetype extensions

-- ls.filetype_extend('X', {'Y', 'Z'})
-- load snippets for 'Y' and 'Z' filetypes when editing 'X' filetype

ls.filetype_extend('cpp', {'c'})
ls.filetype_extend('markdown', {'tex'})

-- }}}

-- vim: foldmethod=marker foldlevel=0
