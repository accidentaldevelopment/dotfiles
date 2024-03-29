set -u fish_greeting

set -x GPG_TTY "$(tty)"
set -x EDITOR nvim
# set -x PAGER less
set -x MANPAGER 'nvim +Man!'
set -x HOMEBREW_NO_ANALYTICS 1
set -x SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

set -x LESS_TERMCAP_mb (tput bold; tput setaf red) # begin bold
set -x LESS_TERMCAP_md (tput setaf 74) # begin bold
set -x LESS_TERMCAP_me (tput sgr0) # begin bold
set -x LESS_TERMCAP_us (tput smul; tput setaf 182) # begin underline
set -x LESS_TERMCAP_ue (tput rmul; tput sgr0) # begin underline
set -x LESS_TERMCAP_so (tput smso) # begin standout-mode - info box
set -x LESS_TERMCAP_se (tput rmso; tput sgr0) # begin standout-mode - info box

if status is-interactive
    fish_vi_key_bindings

    fish_add_path "$HOME/.cargo/bin"
    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin

    alias sr='ssh -l root'

    # source "$(brew --prefix fzf)/shell/key-bindings.fish" && fzf_key_bindings

    mise activate fish | source
    starship init fish | source
end
