vim.loader.enable()

-- This must be loaded before lazy, for leader keys.
require('options')

-- Automatically verify or install packer
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
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

require('lazy').setup({
  defaults = {
    lazy = true,
  },
  spec = {
    { import = 'plugin' },
    { import = 'plugin.dev.rust', enabled = vim.system({ 'which', 'cargo' }):wait().code == 0 },
    { import = 'plugin.dev.web', enabled = true },
    { import = 'plugin.dev.go', enabled = vim.system({ 'which', 'go' }):wait().code == 0 },
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
  performance = {
    rtp = {
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'health',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'rplugin',
        -- 'spellfile',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  desc = 'Last minute loading of some files',
  callback = function()
    require('keymaps')
    require('commands')
  end,
})
