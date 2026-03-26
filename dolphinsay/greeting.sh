# only show for interactive shells
case $- in
	*i*) ;;
	*) return ;;
esac

if command -v fortune >/dev/null 2>&1; then
	message="$(fortune "${XDG_CONFIG_HOME:-"$HOME/.config"}/dolphinsay/text")"
	if command -v dolphinsay >/dev/null 2>&1; then
		if command -v lolcat >/dev/null 2>&1; then
			echo "$message" | dolphinsay -r | lolcat
		else
			echo "$message" | dolphinsay -r
		fi
	else
		echo "$message"
	fi
fi
