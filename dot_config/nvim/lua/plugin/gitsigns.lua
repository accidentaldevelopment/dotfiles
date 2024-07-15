return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  opts = {
    numhl = true,
    current_line_blame_opts = {
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    },
    current_line_blame_formatter = ' <author>, <author_time> - <summary> ',
    on_attach = function(buffer)
      local wk = require('which-key')

      wk.add({
        buffer = buffer,
        { ']h', '<cmd>Gitsigns nav_hunk next<cr>', desc = 'Next hunk' },
        { ']H', '<cmd>Gitsigns nav_hunk last<cr>', desc = 'Last hunk' },
        { '[h', '<cmd>Gitsigns nav_hunk prev<cr>', desc = 'Previous hunk' },
        { '[H', '<cmd>Gitsigns nav_hunk first<cr>', desc = 'First hunk' },
        { '<leader>gh', group = 'hunk' },
        { '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset Hunk' },
        {
          mode = { 'o', 'x' },
          { 'ih', '<cmd>Gitsigns select_hunk<cr>', desc = 'Select Hunk' },
        },
      })
    end,
  },
}
