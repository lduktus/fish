function _fzf_change_dir
    # TODO
    # - use fd or fdfind
    # - add support for symbolic links
    if command -v fdfind > /dev/null
        set find_cmd  fdfind -L -t d .
        set pwd_bind  "ctrl-r:reload(fdfind -L -t d .)"
        set home_bind "ctrl-h:reload(fdfind -L -t d . $HOME)"
    else if command -v fd > /dev/null
        set find_cmd  fd -L -t d .
        set pwd_bind  "ctrl-r:reload(fd -L -t d .)"
        set home_bind "ctrl-h:reload(fd -L -t d . $HOME)"
    else
        set find_cmd  find . -type d -not -path '*/\.*'
        set home_bind "ctrl-h:reload(find -L $HOME -type d -not -path '*/\.*' 2> /dev/null)"
        set pwd_bind  "ctrl-r:reload(find -L . -type d -not -path '*/\.*' 2> /dev/null)"
    end
    set selection ($find_cmd 2>/dev/null | 
            fzf \
                --no-multi \
                --bind $pwd_bind \
                --bind $home_bind \
                --header 'ctrl-r: relative - ctrl-h: home'
                )

    if test $status -eq 0
        if test -d $selection
            cd $selection
        end
    end

    commandline --function repaint

end
