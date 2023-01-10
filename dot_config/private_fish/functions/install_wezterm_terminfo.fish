function install_wezterm_terminfo -d 'download and install wezterm terminfo'
    echo 'downloading wezterm terminfo'

    set tempfile $(mktemp)
    set out_dir '~/.terminfo'

    if fish_is_root_user
        set out_dir /usr/share/terminfo
    end

    curl -# -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo

    echo 'compiling wezterm terminfo'
    tic -x -o $out_dir $tempfile
    rm $tempfile
end
