alias v="$EDITOR"

function last_history_item
    echo $history[1]
end

abbr --add !! --position anywhere --function last_history_item

fish_config theme choose "Catppuccin Mocha"
