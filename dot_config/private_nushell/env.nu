export-env {
  use std "path add"

  const paths: list<path> = [
    ~/.cargo/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
  ]

  for p in $paths {
    if ($p | path exists) {
      path add $p
    }
  }
}
