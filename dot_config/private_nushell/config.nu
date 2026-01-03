$env.EDITOR = 'nvim'
$env.PROMPT_INDICATOR_VI_NORMAL = ''
$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.CARAPACE_BRIDGES = 'fish'
$env.MANPAGER = r#'sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, "", $0); gsub(/.\x08/, "", $0); print }'\'' | bat -p -lman''#

$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)
$env.XDG_STATE_HOME = ($env.HOME | path join .local state)
$env.XDG_DATA_HOME = ($env.HOME | path join .local share)

$env.config.cursor_shape = {
  vi_insert: line
  vi_normal: block
  emacs: line
}
$env.config.datetime_format.normal = "%y-%m-%d %I:%M:%S%p"
$env.config.edit_mode = "vi"
# Show _all_ the decimal places!
$env.config.filesize.precision = null
$env.config.filesize.unit = 'metric'
$env.config.history.file_format = 'sqlite'
$env.config.show_banner = 'short'
$env.config.table.mode = 'compact'
$env.config.use_kitty_protocol = true

$env.config.menus ++= [{
    name: completion_menu
    only_buffer_difference: false
    marker: ''
    type: {
        layout: columnar
    }
    style: {
        text: green
        selected_text: green_reverse
    }
}]

export-env {
  let 1p_agent_path = $'($env.HOME)/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock'
  if ($1p_agent_path | path exists) {
    $env.SSH_AUTH_SOCK = $1p_agent_path
  }
}

$env.config.keybindings ++= [{
    modifier: control,
    mode: [vi_normal, vi_insert],
    keycode: 'char_[',
    event: {
      send: vichangemode,
      mode: normal
    }
  }, {
    modifier: control,
    keycode: Space,
    mode: vi_insert,
    event: {
      send: menu
      name: completion_menu
    }
  }, {
    modifier: control,
    keycode: Char_y,
    mode: vi_insert,
    event: {
      send: Enter
    }
  },
]
