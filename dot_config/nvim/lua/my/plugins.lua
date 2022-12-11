local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
  packer_bootstrap = true
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
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }
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
  use 'moll/vim-bbye'

  use {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = function()
      require 'my.noice'
    end,
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
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
      require 'my.whichkey'
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
      require 'my.colorscheme'
    end,
  }

  -- cmp plugins
  use {
    'hrsh7th/nvim-cmp', -- The completion plugin
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require 'my.cmp'
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- enable LSP
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'lvimuser/lsp-inlayhints.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require 'my.lsp'
    end,
  }

  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup()
    end,
  }

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
      require 'my.telescope'
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'p00f/nvim-ts-rainbow',
    },
    config = function()
      require 'my.treesitter'
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
      require 'my.gitsigns'
    end,
  }

  use 'ellisonleao/glow.nvim'

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  }
  -- Lua
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'my.todo'
    end,
  }

  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end,
  }

  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  }

  use {
    'rebelot/heirline.nvim',
    config = function()
      require 'my.heirline'
    end,
  }

  use {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'md' },
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  }

  use 'folke/neodev.nvim'

  use {
    'dnlhc/glance.nvim',
    config = function()
      require 'my.glance'
    end,
  }
end)

if packer_bootstrap then
  packer.sync()
end
