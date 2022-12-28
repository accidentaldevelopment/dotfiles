local M = {}

function M.format()
  vim.lsp.buf.format()
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')

  local enabled = false
  if #require('null-ls.sources').get_available(ft, require('null-ls').methods.FORMATTING) > 0 then
    enabled = client.name == 'null-ls'
  else
    enabled = not (client.name == 'null-ls')
  end

  -- if client.name == 'tsserver' then
  --   enabled = false
  -- end

  -- util.info(client.name .. " " .. (enable and "yes" or "no"), "format")

  client.server_capabilities.documentFormattingProvider = enabled
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = buf,
      desc = 'Format the current buffer',
      group = vim.api.nvim_create_augroup('LspFormat', {}),
      callback = M.format,
    })
  end
end

return M
