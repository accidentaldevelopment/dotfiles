local M = {}

--- Return a function that calls `fn` with `...` as args.
--- @param fn function The function to call
--- @param ... any arguments passed to `fn`
--- @treturn function A function that calls `fn` with the given `args`.
function M.lazy(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

--- Return a function that calls `fn` with `...` as args.
--- @param mod string Full path to module containing `fn`.
--- @param fn string The function to call
--- @param ... any arguments passed to `fn`
--- @return function A function that calls `fn` with the given `args`.
function M.lazy_require(mod, fn, ...)
  local args = { ... }
  return function()
    require(mod)[fn](unpack(args))
  end
end

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

-- TODO: This really probably shouldn't live here.
M.lang_tools = {
  ---@param name string
  ---@param bufnr number?
  register = function(name, bufnr)
    bufnr = bufnr or 0
    local cur = vim.b[bufnr]._lang_tools or {}
    cur[name] = true
    vim.b[bufnr]._lang_tools = cur
  end,

  ---@param client_id number
  ---@param bufnr number?
  unregister = function(client_id, bufnr)
    local client = vim.lsp.get_client_by_id(client_id)
    if client == nil then
      return
    end
    local cur = vim.b[bufnr]._lang_tools or {}
    cur[client.name] = nil
    vim.b[bufnr]._lang_tools = cur
  end,

  ---@param bufnr number?
  get = function(bufnr)
    bufnr = bufnr or 0
    return vim.b[bufnr]._lang_tools or {}
  end,

  ---@param bufnr number?
  ---@return boolean `true` if there are any language tools attached.
  has_any = function(bufnr)
    local cur = vim.b[bufnr or 0]._lang_tools or {}
    -- if there is anything in the set, we can immediately return true
    for _ in pairs(cur) do
      return true
    end
    return false
  end,
}

return M
