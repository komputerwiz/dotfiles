function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # User
    set -l color_user $fish_color_user
    switch "$USER"
      case root toor
        if set -q fish_color_user_root
          set color_user $fish_color_user_root
        end
    end
    set_color --bold $color_user
    echo -n $USER
    set_color normal

    echo -n '@'

    # Host
    set_color --bold $fish_color_host
    echo -n (prompt_hostname)
    set_color normal

    echo -n ':'

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    #echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '> '
    set_color normal
end
