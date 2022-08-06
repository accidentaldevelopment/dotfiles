#!/bin/sh

# Creates and attaches to a new tmux session in the directory selected via fzf.

set -e

has_session() {
  tmux has-session -t "=$1"
}

# Start from ~ and go a max of two levels deep. It's unlikely I'll have anything deeper than that.
# TODO: Actually start keeping all code (i.e., things I'll open in tmux) in a single known directory.
#   That will make this find/lookup quite a bit neater.
new_dir="$(fd --max-depth=2 --type d '' "$HOME" | fzf --reverse --header 'Open in new session' --preview 'ls {}')"

# Use the directory's basename as the session name.
session_name="$(basename "$new_dir")"

if ! has_session "$session_name"; then
  tmux new-session -d -s "$session_name" -c "$new_dir"
fi

if [ -z "$TMUX" ]; then
  tmux attach -t "$session_name"
else
  tmux switch-client -t "$session_name"
fi
