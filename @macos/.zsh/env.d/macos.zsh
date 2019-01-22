# prevent bsdtar from including extended attr / AppleDouble files (._*) in archives
export COPYFILE_DISABLE=true

# default PATH does not include /usr/local/sbin (homebrew admin utils)
export PATH="/usr/local/sbin:$PATH"
