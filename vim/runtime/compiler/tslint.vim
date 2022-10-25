" Vim Compiler File
" Compiler:     tslint
" Maintainer:   Matthew Barry <matthew@komputerwiz.net>
" Last Change:  2018-06-21

if exists("current_compiler")
  finish
endif
let current_compiler = "tslint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=npx\ tslint\ -p\ .

CompilerSet errorformat=
      \%EERROR:\ %f[%l\\,\ %c]:\ %m,
      \%WWARNING:\ %f[%l\\,\ %c]:\ %m,
      \%E%f[%l\\,\ %c]:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
