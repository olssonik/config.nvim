return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    insert_at_start = true,
  },
  version = '^1.0.0',
  keys = {
    { '<leader>h', '<Cmd>BufferPrevious<CR>', desc = 'Go to previous buffer' },
    { '<leader>l', '<Cmd>BufferNext<CR>', desc = 'Go to next buffer' },
    { '<leader>cb', '<Cmd>BufferClose<CR>', desc = 'Close buffer' },
  },
}
