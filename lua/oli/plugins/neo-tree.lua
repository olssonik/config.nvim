return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree reveal',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    -- ===================================================================
    -- Custom Theme and Highlights
    -- ===================================================================
    window = {
      position = 'right',
      width = 30,
      mappings = {
        ['\\'] = 'close_window',
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none', -- Unmap space from open
      },
      -- This is where we override the default colors
      highlights = {
        -- Make the background match the editor background for a seamless look
        background = { bg = '#16161D' }, -- Kanagawa's sumiInk0
        normal = { bg = '#16161D' },
        normal_nc = { bg = '#16161D' },

        -- Subtle border color
        win_separator = { fg = '#363646' }, -- Kanagawa's sumiInk3

        -- Use Kanagawa's colors for folder icons and git status
        directory = { fg = '#7E9CD8' }, -- crystalBlue
        git_modified = { fg = '#E6C384' }, -- boatYellow2
        git_added = { fg = '#98BB6C' }, -- springGreen
        git_deleted = { fg = '#E46876' }, -- waveRed

        -- A more subtle highlight for the currently selected line
        cursor_line = { bg = '#1F1F28' }, -- Kanagawa's sumiInk1
      },
    },
    -- ===================================================================

    -- Other filesystem settings
    filesystem = {
      -- We move the window settings from here into the main `window` table above
      -- to apply the highlights to all neo-tree sources, not just files.
      filtered_items = {
        visible = true, -- show hidden files by default
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
    },

    -- Git status integration
    git_status = {
      symbols = {
        added = '', -- Alternative: 
        modified = '', -- Alternative: 
        deleted = '',
        renamed = '',
        untracked = '',
        ignored = '',
        unstaged = '',
        staged = '',
        conflict = '',
      },
    },
  },
}
