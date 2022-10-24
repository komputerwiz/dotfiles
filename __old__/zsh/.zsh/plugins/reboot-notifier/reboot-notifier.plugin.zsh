if [[ "$REBOOT_NOTIFIER_INDICATOR" == "" ]]; then
    REBOOT_NOTIFIER_INDICATOR="%{$fg_bold[yellow]%}(*)%{$reset_color%}"
fi

function reboot_notifier_prompt_info() {
    if [[ -f "/run/reboot-required" ]]; then
        echo "$REBOOT_NOTIFIER_INDICATOR"
    fi
}

if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
    RPS1='$(reboot_notifier_prompt_info)'
fi
