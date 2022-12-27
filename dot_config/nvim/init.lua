require('options')

-- Automatically verify or install packer
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugin', {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
  checker = {
    enabled = true,
  },
  ui = {
    border = 'rounded',
  },
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  desc = 'Handle late loading',
  callback = function()
    require('keymaps')
  end,
})
