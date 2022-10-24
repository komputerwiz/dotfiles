" Vim Compiler File
" Compiler:    maven
" Maintainer:  Matthew Barry <matthew@komputerwiz.net>
" Last Change: 2022-02-25

if exists("current_compiler")
  finish
endif
let current_compiler = "maven"

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=mvn\ -B\ $*

" Ignore [INFO] and [debug] messages
CompilerSet errorformat=
      \%-G[INFO]\ %.%#,
      \%-G[debug]\ %.%#

" POM file errors
CompilerSet errorformat+=
      \[FATAL]\ Non-parseable\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#,
      \[%tRROR]\ Malformed\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#

" Compile errors
CompilerSet errorformat+=
      \[%tARNING]\ %f:[%l\\,%c]\ %m,
      \[%tRROR]\ %f:[%l\\,%c]\ %m

" Message from Test Frameworks: JUnit 5, TestNG, JMockit, and AssertJ
CompilerSet errorformat+=
      \%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ FAILURE!,
      \%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ ERROR!,
      \%+Z%\\s%#at\ %f(%\\f%\\+:%l),
      \%+C%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
