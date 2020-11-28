# fisher plugin manager
curl -sL https://git.io/fisher | source && fisher update

# environment variables
set -Ux EDITOR nvim
set -U fish_user_paths $fish_user_paths $HOME/.local/bin

# fish config
set -U fish_greeting ''

# syntax highlighting colors (solarized)
#
#                              dark          light
# base03  (#002b36) 8 brblack    background
# base02  (#073642) 0 black      bg highlight
# base01  (#586e75) A brgreen    secondary     emphasis
# base00  (#657b83) B bryellow                 default
# base0   (#839496) C brblue     default
# base1   (#93a1a1) E brcyan     emphasis      secondary
# base2   (#eee8d5) 7 white                    bg highlight
# base3   (#fdf6e3) F brwhite                  background
#
# yellow  (#b58900) 3 yellow
# orange  (#cb4b16) 9 brred
# red     (#dc322f) 1 red
# magenta (#d33682) 5 magenta
# violet  (#6c71c4) D brmagenta
# blue    (#268bd2) 4 blue
# cyan    (#2aa198) 6 cyan
# green   (#859900) 2 green

set -U fish_color_normal normal                          # default color
set -U fish_color_command green                          # commands
set -U fish_color_quote cyan                             # quoted blocks of text
set -U fish_color_redirection violet                     # IO redirection
set -U fish_color_end blue                               # process separators like ';' and '&'
set -U fish_color_error red                              # potential errors
set -U fish_color_param brblue                           # regular command parameters
set -U fish_color_comment brgreen                        # code comments
set -U fish_color_match --background=brblue              # matching parenthesis
set -U fish_color_selection brblack --background=brblue  # selecting text (in vi visual mode)
set -U fish_color_search_match brblue --background=black # history search matches and selected pager item (must be a background)
set -U fish_color_operator magenta                       # parameter expansion operators like '*' and '~'
set -U fish_color_escape magenta                         # character escapes like '\n' and '\x70'
set -U fish_color_autosuggestion brgreen                 # autosuggestion
set -U fish_color_cancel -r                              # `^C` indicator on a canceled command
set -U fish_color_valid_path --underline

# prompt colors
set -U fish_color_cwd yellow         # working directory
set -U fish_color_cwd_root red       # working directory if running as root
set -U fish_color_user cyan          # username
set -U fish_color_user_root red      # username if running as root
set -U fish_color_host cyan          # host system
set -U fish_color_host_remote yellow # host system if running remotely (ssh)
set -U fish_color_status red         # exit status of previous command

# completion colors
set -U fish_pager_color_progress brblue --background=black # progress bar at bottom-left corner
set -U fish_pager_color_prefix brcyan --bold               # string to be completed
set -U fish_pager_color_completion brblue                  # completion itself
set -U fish_pager_color_description brgreen                # completion description

# miscellaneous colors
set -U fish_color_history_current --bold
