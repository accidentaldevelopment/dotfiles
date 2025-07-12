local cache = {}

local function repo_dir(path)
  local result = vim.system({ 'jj', '--ignore-working-copy', 'root' }, { cwd = vim.fs.dirname(path) }):wait()
  if result.code == 0 then
    return vim.trim(result.stdout)
  else
    return nil
  end
end

function cache:invalidate(buf_id)
  local item = self[buf_id]
  if item == nil then
    return false
  end
  pcall(function()
    item.fs_event:stop()
    item.timer:stop()
  end)
  item[buf_id] = nil
end

function cache:set(buf_id, obj)
  self:invalidate(buf_id)
  cache[buf_id] = obj
end

function cache:has(buf_id)
  return self[buf_id] ~= nil
end

local function start_watching(buf_id, path)
  local repo = repo_dir(path)
  if repo == nil then
    return false
  end
  local watchfile = vim.fs.joinpath(repo, '.jj/working_copy')

  local buf_fs_event, err = vim.loop.new_fs_event()
  if err ~= nil then
    vim.notify(err, vim.log.levels.ERROR)
    return false
  end
  local timer, err = vim.loop.new_timer()
  if err ~= nil then
    vim.notify(err, vim.log.levels.ERROR)
    return false
  end

  local set_ref_text = function()
    vim.system(
      { 'jj', '--ignore-working-copy', 'file', 'show', '-r', '@-', '"' .. path .. '"' },
      { cwd = vim.fs.dirname(path), text = true },
      vim.schedule_wrap(function(res)
        require('mini.diff').set_ref_text(buf_id, res.stdout)
      end)
    )
  end

  local watch_index = function(_, filename, _)
    if filename ~= 'checkout' then
      return
    end
    ---@diagnostic disable-next-line: need-check-nil checked for error above
    timer:stop()
    ---@diagnostic disable-next-line: need-check-nil checked for error above
    timer:start(50, 0, set_ref_text)
  end
  ---@diagnostic disable-next-line: need-check-nil checked for error above
  buf_fs_event:start(watchfile, { recursive = true }, watch_index)

  cache:set(buf_id, { fs_event = buf_fs_event, timer = timer })

  set_ref_text()
end

return {
  'echasnovski/mini.diff',
  event = 'BufReadPre',
  opts = {
    source = {
      {
        name = 'jj',
        attach = function(buf_id)
          if cache:has(buf_id) then
            return false
          end

          local path, err = vim.uv.fs_realpath(vim.api.nvim_buf_get_name(buf_id))
          if err ~= nil then
            vim.notify(err, vim.log.levels.ERROR)
            return false
          end

          return start_watching(buf_id, path)
        end,
        detach = function(buf_id)
          cache:invalidate(buf_id)
        end,
      },
    },
  },
  config = function(_, opts)
    local diff = require('mini.diff')
    vim.list_extend(opts.source, {
      diff.gen_source.git(),
      diff.gen_source.save(),
    }, #opts.source)

    diff.setup(opts)
  end,
}
