$env.config.completions.external.enable = true
$env.config.completions.external.completer = {|place: record|
  CARAPACE_LENIENT=1 carapace ($place.command | first) nushell ...$place.command | from json
}
