$env.EDITOR = 'nvim'
$env.PROMPT_INDICATOR_VI_NORMAL = ''
$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.CARAPACE_BRIDGES = 'fish'

$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)
$env.XDG_STATE_HOME = ($env.HOME | path join .local state)
$env.XDG_DATA_HOME = ($env.HOME | path join .local share)

$env.config.filesize.unit = 'metric'
# Show _all_ the decimal places!
$env.config.filesize.precision = null
$env.config.table.mode = 'compact'
$env.config.history.file_format = 'sqlite'
$env.config.show_banner = 'short'
$env.config.use_kitty_protocol = true
$env.config.datetime_format.normal = "%y-%m-%d %I:%M:%S%p"
$env.config.edit_mode = "vi"
$env.config.cursor_shape = {
  vi_insert: line
  vi_normal: block
  emacs: line
}

$env.config.menus ++= [{
    name: completion_menu
    only_buffer_difference: false # Search is done on the text written after activating the menu
    marker: '',                  # Indicator that appears with the menu is active
    type: {
        layout: columnar          # Type of menu
        columns: 4                # Number of columns where the options are displayed
        col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2            # Padding between columns
    }
    style: {
        text: green                   # Text style
        selected_text: green_reverse  # Text style for selected option
        description_text: yellow      # Text style for description
    }
}]
