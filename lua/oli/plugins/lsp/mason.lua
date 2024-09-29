return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- import mason
    local mason = require 'mason'

    -- import mason-lspconfig
    local mason_lspconfig = require 'mason-lspconfig'

    local mason_tool_installer = require 'mason-tool-installer'

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = {
        'html',
        'cssls',
        'lua_ls',
        'emmet_ls',
        'pylsp',
        'gopls',
        'clangd',
        'jsonls',
        'dockerls',
        'sqlls',
        'marksman',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'isort',
        'flake8',
        'eslint_d',
        'clang-format',
        'sqlfluff',
        'cpplint',
        'golangci-lint',
        'hadolint',
        'jsonlint',
        'markdownlint',
      },
    }
  end,
}
