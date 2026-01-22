function fish_greeting
	if not type -q fortune
		return
	end

	# Set greetings directory using XDG_CONFIG_HOME with fallback
	if test -z "$fish_greetings_dir"
		if test -z "$XDG_CONFIG_HOME"
			set fish_greetings_dir "$HOME/.config/greetings"
		else
			set fish_greetings_dir "$XDG_CONFIG_HOME/greetings"
		end
	end

	set message (fortune "$fish_greetings_dir/text")

	if type -q cowsay
		set -x COWSAY_ONLY_COWPATH 1
		set -x COWPATH "$fish_greetings_dir/art"
		echo "$message" | cowsay -r
	else
		echo "$message"
	end
end
