--- Git status. Shows branch name and status counts.
return {
  condition = function()
    return vim.b.minidiff_summary ~= nil
  end,
  init = function(self)
    ---@diagnostic disable-next-line: undefined-field - This variable exists as long as the above condition is true.
    self.status_dict = vim.b.minidiff_summary
    self.has_changes = ((self.status_dict.add ~= 0) or (self.status_dict.delete ~= 0) or (self.status_dict.change ~= 0))
  end,
  hl = 'SLGitBranch',
  {
    provider = function()
      return ' '
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '(',
  },
  {
    provider = function(self)
      local count = (self.status_dict.add or 0)
      if count > 0 then
        return ('+' .. count)
      end
    end,
    hl = 'GitSignsAdd',
  },
  {
    provider = function(self)
      local count = (self.status_dict.delete or 0)
      if count > 0 then
        return ('-' .. count)
      end
    end,
    hl = 'GitSignsDelete',
  },
  {
    provider = function(self)
      local count = (self.status_dict.change or 0)
      if count > 0 then
        return ('~' .. count)
      end
    end,
    hl = 'GitSignsChange',
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ')',
  },
}
