local utils = require('heirline.utils')

local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. '. '
  end,
  -- hl = 'Comment',
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
-- @type hello
local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, 'modified')
    end,
    provider = ' ●',
    hl = 'SLFileFlagsModified',
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, 'modifiable')
        or vim.api.nvim_buf_get_option(self.bufnr, 'readonly')
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, 'buftype') == 'terminal' then
        return '   '
      else
        return ' '
      end
    end,
    hl = 'SLFileFlagsReadOnly',
  },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  condition = function(self)
    return self.is_visible
  end,
  hl = function(self)
    if self.is_active then
      return 'TabLineSel'
    else
      return 'TabLine'
    end
  end,
  TablineBufnr,
  require('plugin.heirline.components.file').FileIcon,
  TablineFileName,
  TablineFileFlags,
}

-- The final touch!
-- local TablineBufferBlock = utils.surround({ '', '' }, function(self)
local TablineBufferBlock = utils.surround({ '| ', ' |' }, function(self)
  if self.is_active then
    return utils.get_highlight('TabLineSel').bg
  else
    return utils.get_highlight('TabLine').bg
  end
end, { TablineFileNameBlock })

local TabPage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
  end,
  hl = function(self)
    if self.is_active then
      return 'TabLineSel'
    else
      return 'TabLine'
    end
  end,
}

local TabPages = {
  condition = function(self)
    return #vim.api.nvim_list_tabpages() > 1
  end,
  { provider = '%=' },
  utils.make_tablist(TabPage),
}

-- and here we go
local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = '', hl = { fg = 'gray' } }, -- left truncation, optional (defaults to "<")
  { provider = '', hl = { fg = 'gray' } } -- right trunctation, also optional (defaults to ...... yep, ">")
  -- by the way, open a lot of buffers and try clicking them ;)
)

return { BufferLine, TabPages }
