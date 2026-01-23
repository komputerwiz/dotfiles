#!/usr/bin/env bash

{{#if dotter.packages.dolphin-thoughts}}
echo "Running strfile for dolphin-thoughts package"
if command -v strfile >/dev/null 2>&1; then
	greetings_dir="${XDG_CONFIG_HOME:-"$HOME/.config"}/greetings/text"
	if [[ -d "$greetings_dir" ]]; then
		for file in "$greetings_dir/"*; do
			if [[ "$file" =~ \.dat$ ]]; then
				continue
			fi
			strfile "$file"
		done
	fi
fi
{{/if}}
