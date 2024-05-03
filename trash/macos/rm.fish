function rm --wraps rm
	argparse --name=rm 'q/quiet' -- $argv
	if set -q _flag_quiet
		command rm $argv
		return
	end

	while true
		read -l -p 'echo -n "Did you mean "; set_color -i yellow; echo -n "trash"; set_color normal; echo -n "? [Yn] "' confirm

		switch $confirm
			case '' Y y
				command trash $argv
				break
			case N n
				command rm $argv
				break
		end
	end
end
