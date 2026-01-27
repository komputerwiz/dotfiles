function dolphinsay
	# Set greetings directory using XDG_CONFIG_HOME with fallback
	if test -z "$dolphinsay_dir"
		if test -z "$XDG_CONFIG_HOME"
			set dolphinsay_dir "$HOME/.config/dolphinsay/art"
		else
			set dolphinsay_dir "$XDG_CONFIG_HOME/dolphinsay/art"
		end
	end

	set -x COWSAY_ONLY_COWPATH 1
	set -x COWPATH "$dolphinsay_dir"
	cowsay $argv
end
