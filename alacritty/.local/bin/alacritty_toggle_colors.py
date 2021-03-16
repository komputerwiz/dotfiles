#!/usr/bin/env python

import yaml
import re

from pathlib import Path

CONFIG_FILE = Path.home() / '.config' / 'alacritty' / 'alacritty.yml'
SCHEME_SEARCH = re.compile(r'colors: \*(\S+)')

with CONFIG_FILE.open('r') as f:
    config = yaml.safe_load(f)
    f.seek(0)
    lines = f.readlines()

line_index = -1
for i, line in enumerate(lines):
    match = SCHEME_SEARCH.search(line)
    if match is not None:
        current_scheme = match.group(1)
        line_index = i
        break

if line_index > 0:
    available_schemes = list(config['schemes'].keys())
    scheme_index = available_schemes.index(current_scheme)
    scheme_index = (scheme_index + 1) % len(available_schemes)

    lines[line_index] = f'colors: *{available_schemes[scheme_index]}\n'

    with CONFIG_FILE.open('w') as f:
        for line in lines:
            f.write(line)
