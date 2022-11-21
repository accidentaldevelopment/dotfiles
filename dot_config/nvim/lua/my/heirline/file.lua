local M = {}

M.FileName = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.filename = filename
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  {
    provider = function(self)
      if self.icon then
        return self.icon .. ' '
      end
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  },
  {
    provider = function(self)
      return self.filename
    end,
  },
}

M.FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = 'Type',
}

M.FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = '',
    hl = { fg = 'green' },
  },
  {
    condition = function()
      return (not vim.bo.modifiable or vim.bo.readonly)
    end,
    provider = '',
    hl = { fg = 'orange' },
  },
}

M.HelpFileName = {
  condition = function()
    return (vim.bo.filetype == 'help')
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ':t')
  end,
  hl = { fg = 'orange' },
}

return M
