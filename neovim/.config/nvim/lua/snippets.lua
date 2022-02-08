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
    s('date', f(function () return os.date('%F') end)),
    s('time', f(function () return os.date('%T') end)),
    s('timetz', f(function () return os.date('%T%z') end)),
    s('datetime', f(function () return os.date('%F %T') end)),
    s('datetimetz', f(function () return os.date('%F %T%z') end)),
  },

  -- }}}
  -- {{{ c

  c = {
    s('ifnd', {
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
    s({trig = 'ro5', desc = 'Rule of 5'}, {
      i(1), t('('), f(copy, 1), t({' const&) = default;', ''}),
      f(copy, 1), t('('), f(copy, 1), t({'&&) noexcept = default;', ''}),
      f(copy, 1), t('& operator=('), f(copy, 1), t({' const&) = default;', ''}),
      f(copy, 1), t('& operator=('), f(copy, 1), t({'&&) noexcept = default;', ''}),
      t('~'), f(copy, 1), t({'() = default;', ''}),
    }),
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
    s('e', {
      t('\\begin{'), i(1), t('}'),
      t({'', '\t'}),
      i(0),
      t({'', '\\end{'}), f(copy, 1), t('}'),
    }),

    s('f', { t('\\frac{'), i(1), t('}{'), i(2), t('}') }),
    s('m', { t('\\( '), i(1), t(' \\)') }),
    s('M', { t('\\[ '), i(1), t(' \\]') }),
    s('(', { t('\\left( '), i(1), t(' \\right)') }),
    s('[', { t('\\left[ '), i(1), t(' \\right]') }),
    s('{', { t('\\left\\{ '), i(1), t(' \\right\\}') }),
  },

  -- }}}
}

-- load 'c' extensions in 'cpp' files
ls.filetype_extend('cpp', {'c'})

-- vim: foldmethod=marker foldlevel=0
