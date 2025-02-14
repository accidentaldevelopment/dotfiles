# Show a list of worktrees and `cd` into the selected one.
export def --env main [
  --workdir (-w): string  # Working directory
]: nothing -> nothing {
  let workdir = $workdir | default (pwd)

  let selected = ^git worktree list | str replace --all --regex '[\[\]]' '' |  ^fzf --border bold --border-label worktrees --margin 10% --with-nth 3 --accept-nth 1

  if ($selected | is-empty) {
    return
  }

  cd $selected
}
