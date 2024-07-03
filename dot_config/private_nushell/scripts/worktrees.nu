# Show a list of worktrees and `cd` into the selected one.
export def --env main [
  --workdir (-w): string  # Working directory
]: nothing -> nothing {
  let workdir = $workdir | default (pwd)
  let worktrees = (
    ^git -C $workdir worktree list
    | lines
    | split column -r '\s+'
    | reject column2
    | each { |p|
      {($p.column3 | str substring 1..-2): $p.column1}
    }
    | into record
    | flatten
  )

  let selected = $worktrees | columns | to text | ^fzf --border bold --border-label worktrees --margin 10%
  if ($selected | is-empty) {
    return
  }
  ^cd ($worktrees | get $selected | to text)
}
