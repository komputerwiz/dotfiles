#!/bin/zsh
bgcolor='#002B36' #000000
fgcolor='#839496' #DDDDDD
bgselectcolor='#073642' #3366FF
fgselectcolor='#268BD2' #FFFFFF
exe=$(dmenu_run -nb "$bgcolor" -nf "$fgcolor" -sb "$bgselectcolor" -sf "$fgselectcolor") && eval "exec $exe"
