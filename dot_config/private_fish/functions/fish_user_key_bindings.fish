function ___forward-char-or-clear -d 'move the cursor forward or clear the screen if the prompt is blank'
    if test -z (commandline)
        echo -n (clear | string replace \e\[3J '')
        commandline -f repaint
    else
        commandline -f forward-char
    end
end

function fish_user_key_bindings -d 'set user-defined key bindings'
    bind -M insert \cr history-pager

    bind -M insert \ch backward-char
    bind -M insert \cl ___forward-char-or-clear
    bind -M insert \ck up-or-search
    bind -M insert \cj down-or-search

    bind -M insert \cn forward-word

    bind -m goto g repaint-mode
    bind -M goto w _worktrees
    bind -M goto -m insert \e repaint-mode
    bind -M goto -m insert \cc repaint-mode
end
