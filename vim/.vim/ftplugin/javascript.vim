" =============================== "
"  Javascript Build using JSLint  "
" =============================== "

setlocal makeprg=jslint\ --nomen\ %
"setlocal errorformat=%-P%f,
                    "\%-G/*jslint\ %.%#*/,
                    "\%*[\ ]%n\ %l\\,%c:\ %m,
                    "\%-G\ \ \ \ %.%#,
                    "\%-GNo\ errors\ found.,
                    "\%-Q

setlocal errorformat=%-P%f,
    \%E%>%\\s%\\?#%n\ %m,%Z%.%#Line\ %l\\,\ Pos\ %c,
    \%-G%f\ is\ OK.,%-Q
