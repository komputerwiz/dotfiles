#!/bin/zsh
exe=$(dmenu_run -nb '#000000' -nf '#DDDDDD' -sb '#3366FF' -sf '#FFFFFF') && eval "exec $exe"
