function _fzf_path
    # TODO
    # use either fdfind or fd
    if command -v fdfind > /dev/null
        set find_cmd  fdfind .
        set pwd_bind  "ctrl-r:reload(fdfind .)"
        set home_bind "ctrl-h:reload(fdfind . $HOME)"
    else if command -v fd > /dev/null
        set find_cmd  fd -L -t d .
        set pwd_bind  "ctrl-r:reload(fd -L -t d .)"
        set home_bind "ctrl-h:reload(fd -L -t d . $HOME)"
    else
        set find_cmd  find . -not -path '*/\.*'
        set home_bind "ctrl-h:reload(find $HOME -not -path '*/\.*' 2> /dev/null)"
        set pwd_bind  "ctrl-r:reload(find . -not -path '*/\.*' 2> /dev/null)"
    end
    set selection ($find_cmd 2>/dev/null |
            fzf\
                --no-multi\
                --bind $pwd_bind \
                --bind $home_bind \
                --header 'ctrl-r: relative - ctrl-h: home'
                )

    if test $status -eq 0
        if test -e $selection
            commandline --insert $selection
        end
    end

    commandline --function repaint

end
