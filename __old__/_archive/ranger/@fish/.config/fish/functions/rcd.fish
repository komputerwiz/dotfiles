function rcd
  set dir_file (mktemp -t ranger_cd.XXX)
  ranger --choosedir=$dir_file
  cd (cat $dir_file) $argv
  rm $dir_file
  commandline -f repaint
end
