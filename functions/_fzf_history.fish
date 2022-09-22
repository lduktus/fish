# shamelessly stolen from the plugin...
# https://github.com/PatrickF1/fzf.fish

function _fzf_history
    # merges the history canges of other fish sessions
    builtin history merge
    set selected_command (history --null |
        fzf --read0\
            --tiebreak=index |
        string collect
    )

    if test $status -eq 0
        commandline --replace $selected_command
    end

    commandline --function repaint
end
