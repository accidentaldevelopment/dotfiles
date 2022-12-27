local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

return {
  condition = conditions.is_git_repo,
  init = function(self)
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
      return ('\239\144\152 ' .. self.status_dict.head)
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
      else
        return nil
      end
    end,
    hl = 'GitSignsAdd',
  },
  {
    provider = function(self)
      local count = (self.status_dict.removed or 0)
      if count > 0 then
        return ('-' .. count)
      else
        return nil
      end
    end,
    hl = 'GitSignsDelete',
  },
  {
    provider = function(self)
      local count = (self.status_dict.changed or 0)
      if count > 0 then
        return ('~' .. count)
      else
        return nil
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
