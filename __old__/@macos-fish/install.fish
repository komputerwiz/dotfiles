# prevent bsdtar from including extended attr / AppleDouble files (._*) in archives
set -Ux COPYFILE_DISABLE true

# default PATH does not include /usr/local/sbin (homebrew admin utils)
set -U fish_user_paths /usr/local/sbin $fish_user_paths
