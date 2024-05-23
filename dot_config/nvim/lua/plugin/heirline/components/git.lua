local conditions = require('heirline.conditions')

--- Git status. Shows branch name and status counts.
return {
  condition = conditions.is_git_repo,
  init = function(self)
    ---@diagnostic disable-next-line: undefined-field - This variable exists as long as the above condition is true.
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = (
      (self.status_dict.added ~= 0)
      or (self.status_dict.removed ~= 0)
      or (self.status_dict.changed ~= 0)
    )
  end,
  hl = 'SLGitBranch',
  {
    provider = function(self)
      -- return ('\239\144\152 ' .. self.status_dict.head)
      return (' ' .. self.status_dict.head)
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
      local count = (self.status_dict.added or 0)
      if count > 0 then
        return ('+' .. count)
      end
    end,
    hl = 'GitSignsAdd',
  },
  {
    provider = function(self)
      local count = (self.status_dict.removed or 0)
      if count > 0 then
        return ('-' .. count)
      end
    end,
    hl = 'GitSignsDelete',
  },
  {
    provider = function(self)
      local count = (self.status_dict.changed or 0)
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
