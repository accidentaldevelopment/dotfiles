complete -c _worktrees -s h -l help -d 'show help info and exit'

function _worktrees --description 'Show worktrees for a git repo and cd into the selected one' --argument-names dir
    argparse h/help -- $argv
    or return

    if set -ql _flag_help
        echo (status current-command) '[-h|--help] [DIR]'
        return 0
    end

    test -n "$dir"; or set dir (pwd)

    set -l raw_data (command git -C $dir worktree list | command awk '{print $1 "\n" $3}' | command tr -d '[]' | string split '\n')
    set -l len (count $raw_data)
    # Fish really needs associative arrays.
    set -l vals $raw_data[(seq 1 2 $len)]
    set -l keys $raw_data[(seq 2 2 $len)]

    set -l selected (printf (string join '\n' $keys) | command fzf --border bold --border-label worktrees --margin 10%)
    if test -n $selected
        if set -l index (contains -i -- $selected $keys)
            cd $vals[$index]
        end
    end
end
