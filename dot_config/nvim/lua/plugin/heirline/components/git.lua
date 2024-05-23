local conditions = require('heirline.conditions')

--- Git status. Shows branch name and status counts.
return {
  condition = function()
    return vim.b.minidiff_summary
  end,
  init = function(self)
    ---@diagnostic disable-next-line: undefined-field - This variable exists as long as the above condition is true.
    self.status_dict = vim.b.minidiff_summary
    self.has_changes = ((self.status_dict.add ~= 0) or (self.status_dict.delete ~= 0) or (self.status_dict.change ~= 0))
  end,
  hl = 'SLGitBranch',
  {
    provider = function(self)
      -- return ('\239\144\152 ' .. self.status_dict.head)
      if vim.b.minigit_summary ~= nil then
        return (' ' .. vim.b.minigit_summary.head_name)
      else
        return ''
      end
    end,
    hl = { bold = true },
  },
  {
    provider = '(',
  },
  {
    provider = function(self)
      local count = (self.status_dict.add or 0)
      return ('+' .. count)
    end,
    hl = 'MiniDiffSignAdd',
  },
  {
    provider = function(self)
      local count = (self.status_dict.delete or 0)
      return ('-' .. count)
    end,
    hl = 'MiniDiffSignDelete',
  },
  {
    provider = function(self)
      local count = (self.status_dict.change or 0)
      return ('~' .. count)
    end,
    hl = 'MiniDiffSignChange',
  },
  {
    provider = ')',
  },
}
