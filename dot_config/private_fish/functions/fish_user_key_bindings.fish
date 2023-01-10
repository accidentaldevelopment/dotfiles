function fish_user_key_bindings -d 'set user-defined key bindings'
    bind -M insert \cr history-pager

    bind -M insert \ch backward-char
    bind -M insert \cl forward-char
    bind -M insert \ck up-or-search
    bind -M insert \cj down-or-search

    bind -M insert \cn forward-word
end
