function ytdl -d "wrapper for yt-dlp with fallback to youtube-dl"
  if type -q yt-dlp
    yt-dlp $argv
  else if type -q youtube-dl
    echo "Note: consider upgrading to yt-dlp"
    youtube-dl $argv
  else
    echo "Error: unable to find ytdl executable"
  end
end
