# TODO: Use better directory. `~/Desktop` is not acceptable. Maybe use an env var?

function _project_jump_get_icon
    set -l remote "$(git ls-remote --get-url 2> /dev/null)"
    if string match -r "github.com" "$remote" >/dev/null
        set_color --bold normal
        echo -n 
    else if string match -r gitlab "$remote" >/dev/null
        set_color --bold FC6D26
        echo -n 
    end
end

function _project_jump_format_project -a project
    pushd "$HOME/Desktop/$project"
    if test -d .git
        set -l branch (git branch --show-current)
        set_color --bold cyan
        echo -n "$project"
        echo -n " $(_project_jump_get_icon)"
        set_color --bold yellow
        echo "  $branch"
    else
        set_color --bold red
        echo "$project"
    end
    popd
end

function _project_jump_parse_project
    read -f selected
    # if not coming from pipe
    if [ "$selected" = "" ]
        # check args
        set -f selected $argv[1]
    end

    # if still empty, return
    if [ "$selected" = "" ]
        return
    end

    set -l match (string match -r ".*(?=\s*󰊢||)" "$selected")
    if test -z $match
        echo -n "$HOME/Desktop/"(string split -f1 ' ' $selected)
    else
        set -l dir (string trim "$match")
        echo "$HOME/Desktop/$dir"
    end
end

function _project_jump_get_projects
    for dir in (command ls "$HOME/Desktop")
        if test -d "$HOME/Desktop/$dir"
            echo "$(_project_jump_format_project $dir)"
        end
    end
end

function _project_jump_get_readme
    set -l dir (_project_jump_parse_project "$argv[1]")
    if test -f "$dir/README.md"
        glow -p -w 150 "$dir/README.md"
    else
        echo
        echo (set_color --bold) "README.md not found"
        echo
        ls --color=always $dir
    end
end

function _project_jump --description "Fuzzy-find over git repos and jump to them"
    argparse 'format=' -- $argv
    if set -ql _flag_format
        _project_jump_get_readme $_flag_format
    else
        set -l selected (_project_jump_get_projects | fzf --ansi --preview-window 'right,70%' --preview "_project_jump --format {}" | _project_jump_parse_project)
        if test -n "$selected"
            cd "$selected"
        end
        commandline -f repaint
    end
end
