-- TODO: If we switch back to `mini.pairs`, remove pcall and check.
--       If we stick with `nvim-autopairs`, delete this entire file.
local ok, mp = pcall(require, 'mini.pairs')

if ok then
  mp.map_buf(0, 'i', '<', { action = 'open', pair = '<>', neigh_pattern = '[%a:].', register = { cr = false } })
  mp.map_buf(0, 'i', '>', { action = 'close', pair = '<>', register = { cr = false } })

  -- Don't close single quote if we're in a lifetime position.
  mp.map_buf(
    0,
    'i',
    "'",
    { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\<&].', register = { cr = false } }
  )
end
