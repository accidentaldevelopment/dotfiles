local M = {}

--- Set format-on-save. If `op` is `nil` then returns the current state.
--- Sends event 'User FormatOnSave' when the option is changed.
---@param op?
---|"'enable'" # Enable format-on-save
---|"'disable'" # Disable format-on-save
---|"'toggle'" # Reverse format-on-save
---@return boolean `true` if format-on-save is enabled
function M.format_on_save(op)
  if op then
    vim.cmd.doautocmd('User FormatOnSave')
    if op == 'enable' then
      vim.b.format_on_save = true
    elseif op == 'disable' then
      vim.b.format_on_save = false
    elseif op == 'toggle' then
      vim.b.format_on_save = not vim.b.format_on_save
    else
      vim.notify('ignoring invalid argument: ' .. op, vim.log.levels.ERROR)
    end
  end
  return vim.b.format_on_save
end

vim.api.nvim_create_user_command('FormatOnSave', function(cmd)
  if M.format_on_save(cmd.fargs[1]) then
    vim.notify('enabled', vim.log.levels.INFO, { title = 'Format on save' })
  else
    vim.notify('disabled', vim.log.levels.INFO, { title = 'Format on save' })
  end
end, {
  nargs = '?',
  desc = 'Toggle format on save',
  -- This really has to be a function?
  complete = function(_, _, _)
    return { 'enable', 'disable', 'toggle' }
  end,
})

function M.format(bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  -- local have_nls = #require('null-ls.sources').get_available(ft, require('null-ls').methods.FORMATTING) > 0

  vim.lsp.buf.format({
    bufnr = bufnr,
    -- filter = function(client)
    --   if have_nls then
    --     return client.name == 'null-ls'
    --   end
    --   return client.name ~= 'null-ls'
    -- end,
  })
end

function M.on_attach(client, buf)
  local caps = client.server_capabilities

  if caps.documentFormattingProvider then
    M.format_on_save('enable')

    vim.keymap.set('n', '<leader>tf', '<cmd>FormatOnSave toggle<cr>', { desc = 'Toggle format on Save' })

    vim.api.nvim_buf_create_user_command(buf, 'Format', function()
      M.format(buf)
    end, {})
    require('which-key').register({
      buffer = buf,
      ['<localleader>l'] = {
        f = {
          { '<cmd>Format<cr>', 'Format buffer', cond = caps.documentFormattingProvider },
          { '<cmd>Format<cr>', 'Format range',  cond = caps.documentRangeFormattingProvider, mode = 'v' },
        },
      },
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormat.' .. buf, {}),
      desc = 'Format the current buffer',
      buffer = buf,
      callback = function(meta)
        if M.format_on_save() then
          M.format(meta.buf)
        end
      end,
    })
  end
end

return M
