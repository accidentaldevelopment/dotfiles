const color_palette = {
    rosewater: "#f5e0dc"
    flamingo: "#f2cdcd"
    pink: "#f5c2e7"
    mauve: "#cba6f7"
    red: "#f38ba8"
    maroon: "#eba0ac"
    peach: "#fab387"
    yellow: "#f9e2af"
    green: "#a6e3a1"
    teal: "#94e2d5"
    sky: "#89dceb"
    sapphire: "#74c7ec"
    blue: "#89b4fa"
    lavender: "#b4befe"
    text: "#cdd6f4"
    subtext1: "#bac2de"
    subtext0: "#a6adc8"
    overlay2: "#9399b2"
    overlay1: "#7f849c"
    overlay0: "#6c7086"
    surface2: "#585b70"
    surface1: "#45475a"
    surface0: "#313244"
    base: "#1e1e2e"
    mantle: "#181825"
    crust: "#11111b"
}

let dark_theme = {
    separator: $color_palette.overlay0
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: $color_palette.blue attr: "b" }
    empty: $color_palette.lavender
    bool: $color_palette.lavender
    int: $color_palette.peach
    duration: $color_palette.text
    filesize: {|e|
          if $e < 1mb {
            $color_palette.green
        } else if $e < 100mb {
            $color_palette.yellow
        } else if $e < 500mb {
            $color_palette.peach
        } else if $e < 800mb {
            $color_palette.maroon
        } else if $e > 800mb {
            $color_palette.red
        }
    }
    date: {|| (date now) - $in |
        if $in < 1hr {
            $color_palette.green
        } else if $in < 1day {
            $color_palette.yellow
        } else if $in < 3day {
            $color_palette.peach
        } else if $in < 1wk {
            $color_palette.maroon
        } else if $in > 1wk {
            $color_palette.red
        }
    }
    range: $color_palette.text
    float: $color_palette.text
    string: $color_palette.text
    nothing: $color_palette.text
    binary: $color_palette.text
    cellpath: $color_palette.text
    row_index: { fg: $color_palette.mauve attr: "b" }
    record: $color_palette.text
    list: $color_palette.text
    block: $color_palette.text
    hints: $color_palette.overlay1
    search_result: { fg: $color_palette.red bg: $color_palette.text }

    shape_and: { fg: $color_palette.pink attr: "b" }
    shape_binary: { fg: $color_palette.pink attr: "b" }
    shape_block: { fg: $color_palette.blue attr: "b" }
    shape_bool: $color_palette.teal
    shape_custom: $color_palette.green
    shape_datetime: { fg: $color_palette.teal attr: "b" }
    shape_directory: $color_palette.teal
    shape_external: $color_palette.teal
    shape_externalarg: { fg: $color_palette.green attr: "b" }
    shape_filepath: $color_palette.teal
    shape_flag: { fg: $color_palette.blue attr: "b" }
    shape_float: { fg: $color_palette.pink attr: "b" }
    shape_garbage: { fg: $color_palette.text bg: $color_palette.red attr: "b" }
    shape_globpattern: { fg: $color_palette.teal attr: "b" }
    shape_int: { fg: $color_palette.pink attr: "b" }
    shape_internalcall: { fg: $color_palette.teal attr: "b" }
    shape_list: { fg: $color_palette.teal attr: "b" }
    shape_literal: $color_palette.blue
    shape_match_pattern: $color_palette.green
    shape_matching_brackets: { attr: "u" }
    shape_nothing: $color_palette.teal
    shape_operator: $color_palette.peach
    shape_or: { fg: $color_palette.pink attr: "b" }
    shape_pipe: { fg: $color_palette.pink attr: "b" }
    shape_range: { fg: $color_palette.peach attr: "b" }
    shape_record: { fg: $color_palette.teal attr: "b" }
    shape_redirection: { fg: $color_palette.pink attr: "b" }
    shape_signature: { fg: $color_palette.green attr: "b" }
    shape_string: $color_palette.green
    shape_string_interpolation: { fg: $color_palette.teal attr: "b" }
    shape_table: { fg: $color_palette.blue attr: "b" }
    shape_variable: $color_palette.pink

    background: $color_palette.base
    foreground: $color_palette.text
    cursor: $color_palette.blue
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: false

    table: {
        mode: compact # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    history: {
        max_size: 100_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "sqlite" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: null # check 'carapace_completer' above as an example
        }
        use_ls_colors: true # set this to true to enable file/path/directory completions using LS_COLORS
    }

    filesize: {
        metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
        format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
    }

    cursor_shape: {
        emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    color_config: $dark_theme
    use_grid_icons: true

    edit_mode: emacs # emacs, vi
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: false # true enables highlighting of external commands in the repl resolved by which.
    recursion_limit: 50 # the maximum number of times nushell allows recursion before stopping it


    hooks: {
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: { null } # return an error message when a command is not found
    }

    menus: [
        # Configuration for default nushell menus
        # Note the lack of source parameter
        {
            name: completion_menu
            only_buffer_difference: false
            marker: null
            type: {
                layout: columnar
                columns: 4
                col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: ide_completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: ide
                min_completion_width: 0,
                max_completion_width: 50,
                max_completion_height: 10, # will be limited by the available lines in the terminal
                padding: 0,
                border: true,
                cursor_offset: 0,
                description_mode: "prefer_right"
                min_description_width: 0
                max_description_width: 50
                max_description_height: 10
                description_offset: 1
                # If true, the cursor pos will be corrected, so the suggestions match up with the typed text
                #
                # C:\> str
                #      str join
                #      str trim
                #      str split
                correct_cursor_pos: false
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
}

use ~/.cache/starship/init.nu
use mise.nu
