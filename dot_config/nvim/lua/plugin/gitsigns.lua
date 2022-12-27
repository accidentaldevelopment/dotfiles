return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  config = function()
    require('gitsigns').setup({
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      current_line_blame_opts = {
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      yadm = {
        enable = false,
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local wk = require('which-key')
        local tscope = require('telescope.builtin')

        wk.register({
          ['<leader>g'] = {
            name = 'Git',
            j = { gs.next_hunk, 'Next Hunk' },
            k = { gs.prev_hunk, 'Prev Hunk' },
            l = { gs.blame_line, 'Blame' },
            p = { gs.preview_hunk, 'Preview Hunk' },
            r = { gs.reset_hunk, 'Reset Hunk' },
            R = { gs.reset_buffer, 'Reset Buffer' },
            s = { gs.stage_hunk, 'Stage Hunk' },
            u = { gs.undo_stage_hunk, 'Undo Stage Hunk' },
            o = { tscope.git_status, 'Open changed file' },
            b = { tscope.git_branches, 'Checkout branch' },
            c = { tscope.git_commits, 'Checkout commit' },
            d = { gs.diffthis, 'Diff' },
          },
        }, { buffer = bufnr })
      end,
    })

    require('scrollbar.handlers.gitsigns').setup()
  end,
}
