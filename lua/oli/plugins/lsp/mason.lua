return {
  'williamboman/mason.nvim',
  lazy = false,
  priority = 1000, -- <-- ADD THIS LINE
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- Import all the plugins we need here
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'
    local lspconfig = require 'lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup mason itself
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    -- ===================================================================
    -- This block is ONLY for LINTERS, FORMATTERS, and other tools
    -- ===================================================================
    mason_tool_installer.setup {
      ensure_installed = {
        -- Formatters
        'prettier',
        'stylua',
        'black',
        'isort',
        'shfmt',
        'gofumpt',

        -- Linters
        'flake8',
        'shellcheck',
        'yamllint',
        'markdownlint-cli',

        -- Debuggers
        'debugpy',
        'delve',
      },
    }

    -- ===================================================================
    -- This block is ONLY for LSP SERVERS
    -- ===================================================================
    mason_lspconfig.setup {
      ensure_installed = {
        'pyright',
        'lua_ls',
        'cssls',
        'html',
        'gopls',
        'jsonls',
        'ts_ls',
        'rust_analyzer',
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ['pyright'] = function()
          lspconfig.pyright.setup {
            capabilities = capabilities,
            settings = {
              pyright = {
                analysis = {
                  diagnosticMode = 'workspace',
                  typeCheckingMode = 'strict',
                },
              },
            },
          }
        end,
      },
    }
  end,
}
