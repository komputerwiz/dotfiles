## GIT INFORMATION

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}=%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-%{$reset_color%}"

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}(git:%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%})%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}git:%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""


## VI MODE INDICATOR

MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"

## REBOOT INDICATOR

REBOOT_NOTIFIER_INDICATOR="%{$fg_bold[yellow]%}✲%{$reset_color%} "

## RETURN VALUE INDICATOR

local return_status="%(?.. %{$fg_bold[red]%}!%{$reset_color%}%{$fg[red]%}%?)%{$reset_color%}"

## ROOT USER COLOR

if [ "$(id -u)" = "0" ] # if root
then USRCOLOR="red"
else USRCOLOR="cyan"
fi


## SET PROMPT ENVIRONMENT VARIABLES

PROMPT='%{$fg_bold[$USRCOLOR]%}%n@%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}
[%!] %# '

RPROMPT='$(reboot_notifier_prompt_info)$(vi_mode_prompt_info)$(git_prompt_info)$(git_prompt_status)${return_status}%{$reset_color%}'
