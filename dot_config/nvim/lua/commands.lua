vim.api.nvim_create_user_command('Logs', 'Telescope noice', { desc = 'Show notification history' })

vim.api.nvim_create_user_command('BufTablet', function()
  local NuiTable = require('nui.table')

  local buf = vim.api.nvim_create_buf(false, true)

  local width = vim.api.nvim_win_get_width(0) - 10
  local height = vim.api.nvim_win_get_height(0) - 10

  local buffers = vim
    .iter(ipairs(vim.api.nvim_list_bufs()))
    :filter(function(_, b)
      return vim.api.nvim_buf_is_loaded(b)
    end)
    :map(function(_, b)
      return {
        buf = b,
        hidden = vim.api.nvim_get_option_value('bufhidden', { buf = b }),
        listed = vim.api.nvim_get_option_value('buflisted', { buf = b }),
        modified = vim.api.nvim_get_option_value('modified', { buf = b }),
      }
    end)

  local tbl = NuiTable({
    bufnr = buf,
    columns = {
      { accessor_key = 'buf', header = 'Buf' },
      { accessor_key = 'hidden', header = 'Hidden' },
      { accessor_key = 'listed', header = 'Listed' },
      { accessor_key = 'modified', header = 'Modified' },
    },
    data = buffers:totable(),
  })

  tbl:render()

  vim.keymap.set('n', 'q', '<c-w>q', { buffer = buf })

  vim.bo[buf].modifiable = false

  vim.api.nvim_open_win(buf, true, {
    border = 'rounded',
    relative = 'win',
    row = 3,
    col = 3,
    width = width,
    height = height,
  })
end, { desc = 'Show table of loaded buffers and their properties' })
