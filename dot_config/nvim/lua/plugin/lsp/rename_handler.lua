---@param b number buffer number
---@return boolean true if the buffer should auto write
local function buffer_should_autowrite(b)
  return not vim.api.nvim_get_option_value('modified', { buf = b })
    and vim.api.nvim_get_option_value('buftype', { buf = b }) == ''
    and vim.api.nvim_get_option_value('buflisted', { buf = b })
end

--- @return number[]
local function autowritable_buffers()
  return vim
    .iter(ipairs(vim.api.nvim_list_bufs()))
    :filter(function(_, b)
      return vim.api.nvim_buf_is_loaded(b)
    end)
    :fold({}, function(t, _, v)
      t[v] = buffer_should_autowrite(v)
      return t
    end)
end

local rename_handler = vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_rename]
vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_rename] = function(err, result, ctx, config)
  local current_autowritables = autowritable_buffers()
  local should_write = {}

  if result.documentChanges then
    for _, change in ipairs(result.documentChanges) do
      local uri = change.newUri or change.textDocument.uri
      local buf = vim.uri_to_bufnr(uri)
      if current_autowritables[buf] ~= false then
        table.insert(should_write, buf)
      end
    end
  elseif result.changes then
    for uri, _ in pairs(result.changes) do
      local buf = vim.uri_to_bufnr(uri)
      if current_autowritables[buf] ~= false then
        table.insert(should_write, buf)
      end
    end
  end

  rename_handler(err, result, ctx, config)

  if vim.g.autosave_on_rename then
    vim.notify(vim.inspect(should_write), vim.log.levels.INFO, { title = 'autosaving buffers' })
    for _, buf in ipairs(should_write) do
      vim.api.nvim_buf_call(buf, function()
        vim.cmd.update()
      end)
    end
  else
    vim.notify(vim.inspect(should_write), vim.log.levels.INFO, { title = 'autosave disabled' })
  end
end
