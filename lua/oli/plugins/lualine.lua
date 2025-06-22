-- lua/oli/plugins/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status'

    local orange_theme = {
      normal = {
        a = { fg = '#090618', bg = '#FF9E3B' }, -- Dark text on a bright orange background
        b = { fg = '#FF9E3B', bg = '#1F1F28' }, -- Orange text on a dark background
        c = { fg = '#DCD7BA', bg = '#16161D' },
      },
      insert = {
        a = { fg = '#090618', bg = '#98BB6C' }, -- Dark text on a green background for Insert mode
        b = { fg = '#98BB6C', bg = '#1F1F28' },
      },
      visual = {
        a = { fg = '#090618', bg = '#E46876' }, -- Dark text on a red/pink background for Visual mode
        b = { fg = '#E46876', bg = '#1F1F28' },
      },
      replace = {
        a = { fg = '#090618', bg = '#D27E99' }, -- Dark text on a magenta background for Replace mode
        b = { fg = '#D27E99', bg = '#1F1F28' },
      },
      command = {
        a = { fg = '#090618', bg = '#957FB8' }, -- Dark text on a violet background
        b = { fg = '#957FB8', bg = '#1F1F28' },
      },
      inactive = {
        a = { fg = '#727169', bg = '#16161D' }, -- Greyed out for inactive windows
        b = { fg = '#727169', bg = '#16161D' },
        c = { fg = '#727169', bg = '#16161D' },
      },
    }


    -- Custom function to get the name of the active LSP server
    local function get_lsp_servername()
      local msg = 'No Active LSP'
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return table.concat(client_names, ', ')
    end

    lualine.setup {
      options = {
        -- Set the theme to our new custom theme
        theme = orange_theme,

        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = { 'NvimTree', 'alpha' },
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = { { 'branch', icon = '' }, 'diff' },
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_rule = 'smart',
          },
        },
        lualine_y = {
          { get_lsp_servername, icon = ' LSP:' },
          'diagnostics',
        },
        lualine_z = { 'progress', 'location' },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = '#ff9e64' },
            icon = ' lazy',
          },
          'filetype',
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'lazy', 'mason' },
    }
  end,
}
