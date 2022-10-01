set -u fish_greeting

set -x GPG_TTY "$(tty)"
set -x EDITOR nvim
set -x PAGER less
set -x HOMEBREW_NO_ANALYTICS 1

if infocmp wezterm &>/dev/null
    set -x TERM wezterm
end

if status is-interactive
    fish_vi_key_bindings

    fish_add_path "~/.cargo/bin"
    fish_add_path "$(brew --prefix)/bin" "$(brew --prefix)/sbin"
    source "$(brew --prefix asdf)/libexec/asdf.fish"

    source "$(brew --prefix fzf)/shell/key-bindings.fish" && fzf_key_bindings

    starship init fish | source
end
