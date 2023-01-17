return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Explorer' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
  end,
  opts = {
    use_popups_for_input = false,
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
  },
}
