function ytdl-live -d "download a *live stream* with robust interruption handling"
  ytdl --hls-use-mpegts --no-part $argv
end
