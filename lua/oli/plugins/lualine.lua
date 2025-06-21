-- lua/oli/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Kanagawa dependency is not needed here
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Custom function to get the name of the active LSP server
    local function get_lsp_servername()
      local msg = "No Active LSP"
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return table.concat(client_names, ", ")
    end

    lualine.setup({
      options = {
        -- THEME
        -- Uses the theme from your active colorscheme. More robust than hardcoding.
        theme = "auto",

        -- SEPARATORS
        -- Gives it the modern "powerline" look
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },

        -- PERFORMANCE
        -- Disables lualine in inactive buffers and certain filetypes for better performance.
        disabled_filetypes = {
          statusline = {},
          winbar = { "NvimTree", "alpha" }, -- Disable winbar for these filetypes
        },
        always_divide_middle = true,
        globalstatus = true, -- Use a single statusline for all windows
      },
      sections = {
        -- Left side
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "" }, "diff" },
        lualine_c = {
          {
            "filename",
            path = 1, -- Relative path
            shorting_rule = "smart", -- Smartly shorten long paths
          },
        },

        -- Middle section is empty
        lualine_y = {
          { get_lsp_servername, icon = " LSP:" }, -- Our custom LSP server name function
          "diagnostics", -- Show Errors, Warnings, Info, Hints
        },

        -- Right side
        lualine_z = { "progress", "location" },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
            icon = " lazy",
          },
          "filetype",
        },
      },
      inactive_sections = {
        -- Make inactive windows less prominent
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy", "mason" }, -- Enable extensions for better integration
    })
  end,
}
