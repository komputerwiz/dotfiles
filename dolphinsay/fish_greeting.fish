function fish_greeting
	if not type -q fortune
		return
	end

	# Set greetings directory using XDG_CONFIG_HOME with fallback
	if test -z "$fish_greetings_dir"
		if test -z "$XDG_CONFIG_HOME"
			set fish_greetings_dir "$HOME/.config/dolphinsay/text"
		else
			set fish_greetings_dir "$XDG_CONFIG_HOME/dolphinsay/text"
		end
	end

	set message (fortune "$fish_greetings_dir")

	if type -q cowsay
		echo "$message" | dolphinsay -r
	else
		echo "$message"
	end
end
