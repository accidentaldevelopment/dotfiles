local M = {}

local setup_done = false

--- Set format-on-save. If `op` is `nil` then returns the current state.
--- Sends event 'User FormatOnSave' when the option is changed.
---@param op? boolean
---@return boolean `true` if format-on-save is enabled
function M.format_on_save(op)
  vim.validate('op', op, 'boolean', true)
  if op ~= nil then
    vim.b.disable_format_on_save = not op
    vim.cmd.doautocmd('User FormatOnSave')
  end
  return not vim.b.disable_format_on_save
end

--- Format the current buffer if enabled.
--- @param force? boolean If `true` then always format.
function M.format(force)
  if force or not vim.b.disable_format_on_save then
    require('conform').format({ timeout_ms = 500 })
  end
end

--- @param bufnr? number Buffer to collect formatters for. If nil or 0 will use the current buffer.
--- @return string[]
function M.get_formatters_for_buffer(bufnr)
  local formatters, lsp_fallback = require('conform').list_formatters_to_run(bufnr)

  if lsp_fallback then
    return vim
      .iter(ipairs(vim.lsp.get_clients({ bufnr = bufnr or 0, method = vim.lsp.protocol.Methods.textDocument_formatting })))
      --- @param c vim.lsp.Client
      :map(function(_, c)
        return c.name
      end)
      :totable()
  end

  return vim
    .iter(ipairs(formatters))
    --- @param f conform.FormatterInfo
    :map(function(_, f)
      return f.name
    end)
    :totable()
end

local function setup()
  if setup_done then
    vim.notify('formatting setup has already run', vim.log.levels.ERROR)
  end
  vim.api.nvim_create_user_command('FormatOnSave', function(cmd)
    if cmd.bang then
      if M.format_on_save(not M.format_on_save()) then
        vim.notify('enabled', vim.log.levels.INFO, { title = 'Format on save' })
      else
        vim.notify('disabled', vim.log.levels.INFO, { title = 'Format on save' })
      end
    else
      if M.format_on_save(cmd.fargs[1]) then
        vim.notify('enabled', vim.log.levels.INFO, { title = 'Format on save' })
      else
        vim.notify('disabled', vim.log.levels.INFO, { title = 'Format on save' })
      end
    end
  end, {
    bang = true,
    nargs = '?',
    desc = 'Toggle format on save',
    -- This really has to be a function?
    complete = function(_, _, _)
      return { true, false }
    end,
  })

  vim.api.nvim_create_user_command('Format', function(cmd)
    M.format(cmd.bang)
  end, {
    desc = 'Format the current buffer',
    bang = true,
  })
end

if not setup_done then
  setup()
  setup_done = true
end

return M
