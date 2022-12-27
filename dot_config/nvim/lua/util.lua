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

return M
