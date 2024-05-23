return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    cond = false,
    opts = {
      numhl = true,
      current_line_blame_opts = {
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      yadm = {
        enable = false,
      },
      on_attach = function(buffer)
        local wk = require('which-key')

        wk.register({
          [']h'] = { '<cmd>Gitsigns nav_hunk next<cr>', 'Next hunk' },
          [']H'] = { '<cmd>Gitsigns nav_hunk last<cr>', 'Last hunk' },
          ['[h'] = { '<cmd>Gitsigns nav_hunk prev<cr>', 'Previous hunk' },
          ['[H'] = { '<cmd>Gitsigns nav_hunk first<cr>', 'First hunk' },
          ['<leader>gh'] = {
            name = 'hunk',
            r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk' },
          },
        }, {
          buffer = buffer,
        })

        wk.register({
          ['ih'] = { '<cmd>Gitsigns select_hunk<cr>', 'Select Hunk' },
        }, {
          mode = { 'o', 'x' },
          buffer = buffer,
        })
      end,
    },
  },
  {
    'echasnovski/mini.diff',
    event = 'BufReadPre',
    opts = {
      view = {
        style = 'sign',
      },
      options = {
        wrap_goto = true,
      },
    },
  },
  {
    'echasnovski/mini-git',
    main = 'mini.git',
    event = 'BufReadPre',
    opts = {},
  },
}
