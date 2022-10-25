" Vim Compiler File
" Compiler:     phpcs
" Maintainer:   Matthew Barry <matthew@komputerwiz.net>
" Last Change:  2018-11-30

if exists("current_compiler")
  finish
endif
let current_compiler = "phpcs"

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=phpcs\ --report=csv

CompilerSet errorformat=
      \%-GFile\\,Line\\,Column\\,Type\\,Message\\,Source\\,Severity%.%#,
      \\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[a-zA-Z0-9_.-]\\,%*[0-9]%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
