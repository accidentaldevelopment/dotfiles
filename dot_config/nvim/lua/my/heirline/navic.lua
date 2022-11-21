local navic = require 'nvim-navic'

return {
  condition = navic.is_available,
  provider = function()
    return navic.get_location { highlight = true }
  end,
  update = { 'CursorMoved' },
}
