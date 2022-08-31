local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local packer = require 'packer'

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself

  use 'alker0/chezmoi.vim'

  use 'editorconfig/editorconfig-vim'
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
  use 'windwp/nvim-autopairs' -- Autopairs, integrates with both cmp and treesitter
  --use "numToStr/Comment.nvim" -- Easily comment stuff
  use {
    'numToStr/Comment.nvim', -- Easily comment stuff
    config = function()
      require('Comment').setup()
    end,
  }
  -- use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = 'Neotree',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      require('neo-tree').setup {
        window = {
          mappings = {
            ['<space>'] = 'none',
          },
        },
        default_component_configs = {
          name = {
            trailing_slash = true,
            use_git_status_colors = true,
          },
        },
      }
    end,
  }
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require 'accidev.bufferline'
    end,
  }
  use 'moll/vim-bbye'
  use {
    'feline-nvim/feline.nvim',
    config = function()
      require 'accidev.feline'
    end,
  }
  --  use "ahmedkhalf/project.nvim"
  --  use "lewis6991/impatient.nvim"
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  }
  --  use "goolord/alpha-nvim"
  use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight
  use {
    'folke/which-key.nvim',
    config = function()
      require 'accidev.whichkey'
    end,
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    module = 'trouble',
    config = function()
      -- Fix for https://github.com/folke/trouble.nvim/issues/153
      local util = require 'trouble.util'
      local _jump_to_item = util.jump_to_item
      util.jump_to_item = function(win, ...)
        return _jump_to_item(win or 0, ...)
      end

      require('trouble').setup()
    end,
  }

  -- Colorschemes
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require 'accidev.colorscheme'
    end,
  }

  -- cmp plugins
  use {
    'hrsh7th/nvim-cmp', -- The completion plugin
    requires = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require 'accidev.cmp'
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- enable LSP
    requires = {
      'j-hui/fidget.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require 'accidev.lsp'
    end,
  }
  --  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  --  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use 'p00f/nvim-ts-rainbow'
  use 'simrat39/rust-tools.nvim'
  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup()
    end,
  }

  use 'preservim/tagbar'

  --  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {
        'stevearc/dressing.nvim',
        config = function()
          require('dressing').setup {}
        end,
      },
    },
    config = function()
      require 'accidev.telescope'
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require 'accidev.treesitter'
    end,
  }
  --  use "JoosepAlviste/nvim-ts-context-commentstring"
  use {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    config = function()
      require('aerial').setup()
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'accidev.gitsigns'
    end,
  }

  use 'ellisonleao/glow.nvim'
end)

if packer_bootstrap then
  packer.sync()
end
