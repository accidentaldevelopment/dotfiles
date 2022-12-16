-- Automatically verify or install packer
local function ensure_installed()
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    }
    vim.cmd.packadd 'packer.nvim'
    return true
  else
    return false
  end
end

local bootstrap_packer = ensure_installed()
local packer = require 'packer'

packer.startup {
  function(use)
    -- Self-management
    use 'wbthomason/packer.nvim'

    -- Used by everything, so just always include it.
    use 'nvim-lua/plenary.nvim'

    use 'alker0/chezmoi.vim'

    use 'gpanders/editorconfig.nvim'

    -- TODO: look into replacing with `famiu/bufdelete.nvim`
    use 'moll/vim-bbye'

    use(require 'plugin.colorscheme')

    -- TODO: Do I use this?
    -- use 'nvim-lua/popup.nvim'

    use(require 'plugin.editor')

    use(require 'plugin.neo-tree')

    use(require 'plugin.noice')

    use(require 'plugin.which-key')

    use(require 'plugin.cmp')

    use(require 'lsp')

    use(require 'plugin.telescope')

    use(require 'plugin.treesitter')

    use(require('plugin.gitsigns'))

    use(require 'plugin.todo')

    use(require 'plugin.heirline')

    use 'folke/neodev.nvim'

    if bootstrap_packer then
      packer.sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  },
}
