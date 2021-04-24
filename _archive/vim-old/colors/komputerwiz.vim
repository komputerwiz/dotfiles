" Based on Slate by Ralph Amissah <ralph@amissah.com>
highlight clear
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "komputerwiz"

highlight Normal guifg=White guibg=grey15
highlight Cursor guibg=khaki guifg=slategrey

highlight ColorColumn guibg=black ctermbg=8
highlight LineNr guifg=grey50 ctermfg=3
highlight VertSplit guibg=#c2bfa5 guifg=grey40 gui=none cterm=reverse
highlight Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
highlight FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=7
highlight IncSearch guifg=green guibg=black cterm=none ctermfg=yellow ctermbg=green
highlight NonText guifg=RoyalBlue guibg=grey15 cterm=bold ctermfg=blue
highlight Question guifg=springgreen ctermfg=green
highlight Search guibg=peru guifg=wheat cterm=none ctermfg=grey ctermbg=blue
highlight SpecialKey guifg=yellowgreen ctermfg=darkgreen
highlight StatusLine guibg=#c2bfa5 guifg=black gui=none cterm=bold,reverse
highlight StatusLineNC guibg=#c2bfa5 guifg=grey40 gui=none cterm=reverse
highlight Title guifg=gold gui=bold cterm=bold ctermfg=yellow

highlight String guifg=SkyBlue ctermfg=darkcyan
highlight Comment term=bold ctermfg=11 guifg=grey40
highlight Constant guifg=#ffa0a0 ctermfg=brown
highlight Special guifg=darkkhaki ctermfg=brown
highlight Identifier guifg=salmon ctermfg=red
highlight Include guifg=red ctermfg=red
highlight PreProc guifg=red guibg=white ctermfg=red
highlight Operator guifg=Red ctermfg=Red
highlight Define guifg=gold gui=bold ctermfg=yellow
highlight Type guifg=CornflowerBlue ctermfg=2
highlight Function guifg=navajowhite ctermfg=brown
highlight Statement guifg=CornflowerBlue ctermfg=lightblue
highlight Structure guifg=green ctermfg=green
highlight Ignore guifg=grey40 cterm=bold ctermfg=7
highlight Todo guifg=orangered guibg=yellow2

highlight ModeMsg guifg=goldenrod cterm=none ctermfg=brown
highlight MoreMsg guifg=SeaGreen ctermfg=darkgreen
highlight WarningMsg guifg=salmon ctermfg=1
highlight ErrorMsg cterm=bold guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1

highlight Visual gui=none guifg=khaki guibg=olivedrab cterm=reverse
highlight VisualNOS cterm=bold,underline
highlight WildMenu ctermfg=0 ctermbg=3

highlight Directory guifg=cyan ctermfg=cyan

highlight DiffAdd ctermbg=4
highlight DiffChange ctermbg=5
highlight DiffDelete cterm=bold ctermfg=4 ctermbg=6
highlight DiffText cterm=bold ctermbg=1

highlight Underlined cterm=underline ctermfg=5
highlight Error guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
highlight SpellErrors guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1

" Invisible characters
highlight NonText guifg=#4a4a59 ctermfg=darkgray
highlight SpecialKey guifg=#4a4a59 ctermfg=darkgray

" Indent Guides
highlight IndentGuidesOdd  guibg=Black ctermbg=Black
highlight IndentGuidesEven guibg=DarkBlue ctermbg=DarkBlue

" Cursor Highlighting
highlight CursorLine cterm=NONE ctermbg=DarkGray guibg=#444444
highlight CursorColumn cterm=NONE ctermbg=DarkGray guibg=#444444
