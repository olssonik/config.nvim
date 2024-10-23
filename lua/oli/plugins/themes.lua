return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        return {
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          LineNr = { fg = '#606060', bg = theme.ui.bg },
          CursorLineNr = { fg = theme.ui.special, bg = theme.ui.bg }, -- Current line number
          SignColumn = { bg = theme.ui.bg },
          GitSignsAdd = { fg = theme.vcs.add, bg = theme.ui.bg },    -- Background for `+`
          GitSignsChange = { fg = theme.vcs.change, bg = theme.ui.bg }, -- Background for `~`
          GitSignsDelete = { fg = theme.vcs.delete, bg = theme.ui.bg }, -- Background for `-`

          DiagnosticError = { fg = theme.diag.error, bg = theme.ui.bg },
          DiagnosticWarn = { fg = theme.diag.warning, bg = theme.ui.bg },
          DiagnosticInfo = { fg = theme.diag.info, bg = theme.ui.bg },
          DiagnosticHint = { fg = theme.diag.hint, bg = theme.ui.bg },

          DiagnosticSignError = { fg = theme.diag.error, bg = theme.ui.bg },
          DiagnosticSignWarn = { fg = theme.diag.warning, bg = theme.ui.bg },
          DiagnosticSignInfo = { fg = theme.diag.info, bg = theme.ui.bg },
          DiagnosticSignHint = { fg = theme.diag.hint, bg = theme.ui.bg },

          DiagnosticVirtualTextError = { fg = theme.diag.error, bg = theme.ui.bg },
          DiagnosticVirtualTextWarn = { fg = theme.diag.warning, bg = theme.ui.bg },
          DiagnosticVirtualTextInfo = { fg = theme.diag.info, bg = theme.ui.bg },
          DiagnosticVirtualTextHint = { fg = theme.diag.hint, bg = theme.ui.bg },
        }
      end,
      theme = 'dragon', -- Set to "dragon" theme
      background = { -- map the value of 'background' option to a theme
        dark = 'dragon', -- match with the theme you're loading
        light = 'lotus',
      },
    }

    -- setup must be called before loading
    vim.cmd 'colorscheme kanagawa-dragon'
  end,
}
