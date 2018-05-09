#!/bin/zsh
bgcolor='#002B36' #000000
fgcolor='#839496' #DDDDDD
bgselectcolor='#073642' #3366FF
fgselectcolor='#268BD2' #FFFFFF
font='Ubuntu Mono-9'
exe=$(dmenu_run -fn "$font" -nb "$bgcolor" -nf "$fgcolor" -sb "$bgselectcolor" -sf "$fgselectcolor") && eval "exec $exe"
