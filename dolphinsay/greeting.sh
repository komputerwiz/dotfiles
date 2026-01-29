# only show for interactive shells
case $- in
	*i*) ;;
	*) return ;;
esac

if command -v fortune >/dev/null 2>&1; then
	message="$(fortune "${XDG_CONFIG_HOME:-"$HOME/.config"}/dolphinsay/text")"
	if command -v dolphinsay >/dev/null 2>&1; then
		echo "$message" | dolphinsay -r
	else
		echo "$message"
	fi
fi
