#!/bin/bash

IMGPATH="${1:-/tmp/screen_locked_$USER.png}"

echo "$IMGPATH"

# take a screenshot
scrot "$IMGPATH"

# darken, desaturate, and blur the image
mogrify -modulate 50,50 -blur 0x15 "$IMGPATH"

# lock the screen with the blurred desktop as the image
i3lock --dpms --color=000000 --image="$IMGPATH" --tiling
