return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'folke/todo-comments.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            -- in telescope.setup -> defaults -> mappings -> i
            ['<C-q>'] = function(prompt_bufnr)
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist()
            end,
          },
        },
      },
    }

    telescope.load_extension 'fzf'

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
  end,
}
