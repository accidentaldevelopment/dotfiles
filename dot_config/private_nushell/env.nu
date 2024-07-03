$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

export-env {
  use std "path add"

  $env.PATH = ($env.PATH | split row (char esep))
  path add ~/.cargo/bin
  path add /opt/homebrew/bin /opt/homebrew/sbin

  $env.PATH = ($env.PATH | uniq)
}

mkdir ~/.cache/starship
^/opt/homebrew/bin/starship init nu | save -f ~/.cache/starship/init.nu
