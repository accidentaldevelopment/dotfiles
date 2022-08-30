local M = {}

--- Returns a function that calls `fn` with `...` as args.
---@tparam fn function The function to call
---@param ... arguments passed to `fn`
---@treturn function A function that calls `fn`.
function M.lazy_fn(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

return M
