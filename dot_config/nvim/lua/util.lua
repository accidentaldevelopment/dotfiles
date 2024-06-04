local M = {}

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return vim.notify(
      'Set ' .. option .. ' to ' .. vim.opt_local[option]:get(),
      vim.log.levels.INFO,
      { title = 'Option' }
    )
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    vim.notify(
      (vim.opt_local[option]:get() and 'Enabled' or 'Disabled') .. ' ' .. option,
      vim.log.levels.INFO,
      { title = 'Option' }
    )
  end
end

return M
