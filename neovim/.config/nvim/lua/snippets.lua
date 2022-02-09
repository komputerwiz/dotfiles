local ls = require('luasnip')

-- {{{ shorthand variables

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- }}}

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
})

-- {{{ helper functions

-- copies the text value of another text field
local copy = function (args)
  return args[1]
end

-- }}}

ls.snippets = {
  -- {{{ global snippets

  all = {
    s({trig='date', name='ISO 8601 Date'}, f(function () return os.date('%F') end)),
    s({trig='time', name='ISO 8601 Time'}, f(function () return os.date('%T') end)),
    s({trig='timetz', name='ISO 8601 Time with Timezone Offset'}, f(function () return os.date('%T%z') end)),
    s({trig='datetime', name='ISO 8601 Date and Time'}, f(function () return os.date('%F %T') end)),
    s({trig='datetimetz', name='ISO 8601 Date and Time with Timezone Offset'}, f(function () return os.date('%F %T%z') end)),
    s('shrug', t('¯\\_(ツ)_/¯')),
  },

  -- }}}
  -- {{{ c

  c = {
    s({trig='ifnd', name='#ifndef Header Guard'}, {
      t('#ifndef '), i(1),
      t({'', '#define '}), f(copy, 1),
      t({'', '', ''}),
      i(0),
      t({'', '', ''}),
      t('#endif // '), f(copy, 1),
    }),
  },

  -- }}}
  -- {{{ cpp

  cpp = {
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
  },

  -- }}}
  -- {{{ markdown

  markdown = {
    s('qso', {t('{{% qso '), i(1), t(' %}}')}),
    s('sup', {t('<sup>'), i(1), t('</sup>')}),
    s('sub', {t('<sub>'), i(1), t('</sub>')}),
  },

  -- }}}
  -- {{{ php

  php = {
    s('php', t({'<?php declare(strict_types=1);', '', ''})),
  },

  -- }}}
  -- {{{ sh

  sh = {
    s('DIR', t({'DIR="$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null && pwd)"', ''})),
  },

  -- }}}
  -- {{{ tex

  tex = {
    s({trig='e', name='TeX Environment'}, {
      t('\\begin{'), i(1), t('}'),
      t({'', '\t'}),
      i(0),
      t({'', '\\end{'}), f(copy, 1), t('}'),
    }),

    s({trig='f', name='Math Fraction'}, { t('\\frac{'), i(1), t('}{'), i(2), t('}') }),
    s({trig='m', name='Inline Math'}, { t('\\( '), i(1), t(' \\)') }),
    s({trig='M', name='Display Math'}, { t('\\[ '), i(1), t(' \\]') }),
    s({trig='(', name='Matching Parentheses: ()'}, { t('\\left( '), i(1), t(' \\right)') }),
    s({trig='[', name='Matching Square Brackets: []'}, { t('\\left[ '), i(1), t(' \\right]') }),
    s({trig='{', name='Matching Curly Braces: {}'}, { t('\\left\\{ '), i(1), t(' \\right\\}') }),
  },

  -- }}}
}

-- load 'c' extensions in 'cpp' files, etc.
ls.filetype_extend('cpp', {'c'})
ls.filetype_extend('markdown', {'tex'})

-- vim: foldmethod=marker foldlevel=0
