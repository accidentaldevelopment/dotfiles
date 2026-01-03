export-env {
  use std "path add"

  path add ~/.cargo/bin
  path add /opt/homebrew/bin /opt/homebrew/sbin
}

do {
  $nu.user-autoload-dirs | each { mkdir $in }

  let autoload = $nu.user-autoload-dirs | first

  /opt/homebrew/bin/starship init nu | save --force ($autoload | path join starship.nu)
  /opt/homebrew/bin/mise activate nu | save --force ($autoload | path join mise.nu)
  /opt/homebrew/bin/carapace _carapace nushell | save --force ($autoload | path join carapace.nu)
}
