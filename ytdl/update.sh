#!/bin/bash
if command -v yt-dlp > /dev/null; then
	yt-dlp -U
fi

if command -v youtube-dl > /dev/null; then
	youtube-dl -U
fi
