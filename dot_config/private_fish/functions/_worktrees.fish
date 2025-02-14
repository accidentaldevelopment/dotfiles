complete -c _worktrees -s h -l help -d 'show help info and exit'

function _worktrees --description 'Show worktrees for a git repo and cd into the selected one' --argument-names dir
    argparse h/help -- $argv
    or return

    if set -ql _flag_help
        echo (status current-command) '[-h|--help] [DIR]'
        return 0
    end

    test -n "$dir"; or set dir (pwd)

    set -l selected (command git -C $dir worktree list | command tr -d '[]' | command fzf --border bold --border-label worktrees --margin 10% --with-nth 3 --accept-nth 1)
    cd $selected
end
