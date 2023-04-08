vim.loader.enable()

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
