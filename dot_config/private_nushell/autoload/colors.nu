  $env.CURRENT_THEME = 0

  def --env switch-theme [] {
      const DARK_THEME = 1
      const LIGHT_THEME = 2
      let system_theme = try {
        term query "\e[?996n" --prefix "\e[?997;" --terminator "n" | decode | into int
      } catch {
        print 'could not determine theme; default to dark'
        $DARK_THEME
      }

      if $system_theme != $env.CURRENT_THEME {
        $env.CURRENT_THEME = $system_theme

        if $system_theme == $DARK_THEME {
          print $"sourcing ($nu.default-config-dir | path join themes catppuccin_mocha.nu)"
            source ($nu.default-config-dir | path join themes catppuccin_mocha.nu)
        } else if $system_theme == $LIGHT_THEME {
            source ($nu.default-config-dir | path join themes catppuccin_latte.nu)
        } else {
            let error_msg = "Unknown system theme returned from the terminal: " + ($system_theme | into string)
            error make {msg: $error_msg }
        }
      }
  }

source ($nu.default-config-dir | path join themes catppuccin_mocha.nu)
# $env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append switch-theme)
