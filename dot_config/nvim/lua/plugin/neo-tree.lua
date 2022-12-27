return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  cmd = 'Neotree',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    require('neo-tree').setup({
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
    })
  end,
}
