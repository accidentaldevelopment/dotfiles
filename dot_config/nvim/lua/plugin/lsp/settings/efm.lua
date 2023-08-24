local js = {
  -- maybe args = { '--prose-wrap=always', '$FILENAME' } }) ?
  require('efmls-configs.formatters.prettier_d'),
  require('efmls-configs.linters.eslint'),
}
local languages = {
  lua = {
    vim.tbl_extend('force', require('efmls-configs.formatters.stylua'), {
      formatCommand = string.format(
        '%s --search-parent-directories ${--range-start:charStart} ${--range-end:charEnd} --color Never -',
        require('efmls-configs.fs').executable('stylua')
      ),
    }),
  },
  fish = {
    require('efmls-configs.formatters.fish_indent'),
    require('efmls-configs.linters.fish'),
  },
  javascript = js,
  javascriptreact = js,
  typescript = js,
  typescriptreact = js,
  markdown = { js.formatter },
}

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  on_attach = function(_, buf)
    local ft = vim.bo[buf].filetype
    local settings = languages[ft]
    if settings then
      for _, v in pairs(settings) do
        if v.formatCommand ~= nil then
          vim.b[buf].has_efm_formatting = true
          return
        end
      end
    end
  end,
}
