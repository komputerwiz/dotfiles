# note the current time right before running a command
function on_fish_preexec --on-event fish_preexec
  set -l rmessage [(date +%T)]
  printf "\e[2m%*s\r" (tput cols) $rmessage
end
