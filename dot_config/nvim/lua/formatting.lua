local M = {}

local setup_done = false

--- Set format-on-save. If `op` is `nil` then returns the current state.
--- Sends event 'User FormatOnSave' when the option is changed.
---@param op? boolean
---@return boolean `true` if format-on-save is enabled
function M.format_on_save(op)
  vim.validate({ op = { op, 'boolean', true } })
  if op ~= nil then
    vim.b.disable_format_on_save = not op
    vim.cmd.doautocmd('User FormatOnSave')
  end
  return not vim.b.disable_format_on_save
end

--- Format the current buffer if enabled.
function M.format()
  require('conform').format({ timeout_ms = 500, lsp_fallback = true })
end

function M.any_formatter_available()
  vim.notify('checking for formatters')
  local conform = require('conform')
  return conform.list_formatters()[1] ~= nil or conform.will_fallback_lsp()
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

  vim.api.nvim_create_user_command('Format', M.format, {
    desc = 'Format the current buffer',
  })
end

if not setup_done then
  setup()
  setup_done = true
end

return M
