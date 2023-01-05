local M = {}

function M.format(bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local have_nls = #require('null-ls.sources').get_available(ft, require('null-ls').methods.FORMATTING) > 0

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if have_nls then
        return client.name == 'null-ls'
      end
      return client.name ~= 'null-ls'
    end,
  })
end

function M.setup(client, buf)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormat.' .. buf, {}),
      desc = 'Format the current buffer',
      buffer = buf,
      callback = function(meta)
        M.format(meta.buf)
      end,
    })
  end
end

return M
