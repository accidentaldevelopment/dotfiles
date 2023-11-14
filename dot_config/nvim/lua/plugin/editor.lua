return {
  {
    'alker0/chezmoi.vim',
    priority = 9900,
    lazy = false,
    cond = false,
    --- @param plugin LazyPlugin
    init = function(plugin)
      for _, a in ipairs(vim.fn.argv()) do
        if a:find('chezmoi-edit', 1, true) ~= nil then
          vim.notify('enabling chezmoi', vim.log.levels.INFO)
          plugin.cond = true
          return nil
        end
      end
    end,
  },
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mf = require('mini.files')
          if vim.bo.filetype == 'minifiles' then
            mf.close()
          else
            local file = vim.api.nvim_buf_get_name(0)
            local file_exists = vim.fn.filereadable(file) ~= 0
            mf.open(file_exists and file or nil)
            mf.reveal_cwd()
          end
        end,
        desc = 'Explorer',
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        desc = 'Setup mini.files options',
        callback = function(args)
          local files = require('mini.files')
          local buffer = args.data.buf_id

          vim.api.nvim_set_option_value('buftype', 'acwrite', { buf = buffer })
          vim.api.nvim_buf_set_name(buffer, string.format('mini.files-%s', vim.loop.hrtime()))
          vim.api.nvim_create_autocmd('BufWriteCmd', {
            buffer = buffer,
            desc = 'synchronize file system changes',
            callback = function()
              files.synchronize()
            end,
          })

          vim.keymap.set('n', '<ESC>', function()
            files.close()
          end, { buffer = buffer })
        end,
      })
    end,
    opts = {
      mappings = {
        go_in_plus = '<CR>',
      },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require('flash').jump()
        end,
      },
      {
        'S',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
      },
    },
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register({
        mode = { 'n', 'v' },
        g = { name = 'goto' },
        gz = { name = 'surround' },
        [']'] = { name = 'next' },
        ['['] = { name = 'prev' },
        ['<leader><tab>'] = { name = 'tabs' },
        ['<leader>L'] = { require('lazy').home, 'Show Lazy' },
        ['<leader>b'] = { name = 'buffer' },
        ['<leader>g'] = { name = 'git' },
        ['<leader>gh'] = { name = 'hunks' },
        ['<leader>o'] = { name = 'open' },
        ['<leader>s'] = { name = 'search' },
        ['<leader>t'] = { name = 'toggle' },
        ['<leader>x'] = { name = 'diagnostics/quickfix' },
      })
    end,
  },
  {
    'echasnovski/mini.cursorword',
    event = 'BufReadPost',
    config = true,
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bD',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Force delete Buffer',
      },
      {
        '<leader>c',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
    },
  },
  -- trouble
  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local hipatterns = require('mini.hipatterns')
      return {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          safety = { pattern = '%f[%w]()SAFETY()%f[%W]', group = 'MiniHipatternsSafety' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  { 'mrjones2014/smart-splits.nvim', lazy = false },
  {
    'echasnovski/mini.pick',
    cmd = 'Pick',
    opts = {
      mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>',
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
      },
      options = {
        content_from_bottom = true,
      },
      window = {
        config = function()
          local height = math.floor(0.618 * vim.o.lines)
          local width = math.floor(0.618 * vim.o.columns)
          return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
          }
        end,
      },
    },
    config = function(_, opts)
      local Pick = require('mini.pick')
      Pick.setup(opts)

      local doc_symbols = function()
        return vim.lsp.buf.document_symbol({
          on_list = function(data)
            local items = vim.tbl_map(function(item)
              return vim.tbl_extend('force', item, { path = item.filename })
            end, data.items)
            return Pick.start({
              source = {
                items = items,
                name = data.title,
              },
            })
          end,
        })
      end

      local workspace_symbols = function()
        return vim.lsp.buf.workspace_symbol('', {
          on_list = function(data)
            local items = vim.tbl_map(function(item)
              return vim.tbl_extend('force', item, { path = item.filename })
            end, data.items)
            return Pick.start({
              source = {
                items = items,
                name = data.title,
              },
            })
          end,
        })
      end

      Pick.registry.document_symbols = doc_symbols
      Pick.registry.workspace_symbols = workspace_symbols
    end,
  },
}
