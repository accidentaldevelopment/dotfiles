set -u fish_greeting

set -x GPG_TTY "$(tty)"
set -x EDITOR nvim
# set -x PAGER less
set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"
set -x HOMEBREW_NO_ANALYTICS 1

if test -e "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    set -x SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
end

set -x LESS_TERMCAP_mb (tput bold; tput setaf red) # begin bold
set -x LESS_TERMCAP_md (tput setaf 74) # begin bold
set -x LESS_TERMCAP_me (tput sgr0) # begin bold
set -x LESS_TERMCAP_us (tput smul; tput setaf 182) # begin underline
set -x LESS_TERMCAP_ue (tput rmul; tput sgr0) # begin underline
set -x LESS_TERMCAP_so (tput smso) # begin standout-mode - info box
set -x LESS_TERMCAP_se (tput rmso; tput sgr0) # begin standout-mode - info box

if status is-interactive
    fish_vi_key_bindings

    # Current fish_cursor_* settings think they don't work for ghostty or
    # wezterm. But they do, so set this and hope the upstream check eventually
    # includes them.
    if contains $TERM xterm-{ghostty,wezterm} wezterm
        set fish_vi_force_cursor 1
    end

    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    fish_add_path "$HOME/.cargo/bin"
    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin

    alias sr='ssh -l root'

    # source "$(brew --prefix fzf)/shell/key-bindings.fish" && fzf_key_bindings

    mise activate fish | source
    starship init fish | source
end
