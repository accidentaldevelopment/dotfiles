local utils = require('heirline.utils')

local M = {}

local file_name = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    self.filename = filename
  end,
}

--- Icon associated with the file type.
M.FileIcon = {
  init = function(self)
    local extension = vim.fn.fnamemodify(self.filename, ':e')
    self.icon, self.icon_color =
      require('nvim-web-devicons').get_icon_color(self.filename, extension, { default = true })
  end,
  provider = function(self)
    if self.icon then
      return self.icon .. ' '
    end
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

--- Full path of the current file
M.FileName = utils.insert(file_name, M.FileIcon, {
  provider = function(self)
    return self.filename
  end,
})

--- File type
M.FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = 'Type',
}

--- A collection of icons for file status:
--- * modified
--- * readonly
M.FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = '',
    hl = 'SLFileFlagsModified',
  },
  {
    condition = function()
      return (not vim.bo.modifiable or vim.bo.readonly)
    end,
    provider = '',
    hl = 'SLFileFlagsReadOnly',
  },
}

--- The name of the help file if the current filetype is help.
M.HelpFileName = {
  condition = function()
    return (vim.bo.filetype == 'help')
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ':t')
  end,
  hl = 'SLHelpFileName',
}

return M
