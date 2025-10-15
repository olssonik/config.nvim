return {
  'williamboman/mason.nvim',
  lazy = false,
  priority = 1000,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Import all necessary plugins
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'
    local lspconfig = require 'lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local keymap = vim.keymap

    -- Set up global diagnostic configuration
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    -- This function will run for EVERY LSP server that attaches to a buffer
    local on_attach = function(client, bufnr)
      -- This is where we define all our keymaps
      local opts = { buffer = bufnr, silent = true }
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
      keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end

    -- Get the capabilities for nvim-cmp
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup mason itself
    mason.setup()

    -- Setup mason-tool-installer
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
        'markdownlint-cli2',

        -- Debuggers
        'debugpy',
        'delve',
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        -- LSP
        'pyright',
        'lua_ls',
        'cssls',
        'html',
        'gopls',
        'jsonls',
        'ts_ls',
        'rust_analyzer',
        'omnisharp',
      },
      handlers = {
        -- This is the default handler that passes the on_attach function and capabilities
        function(server_name)
          lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end,
        -- Custom handler for pyright with stricter settings
        ['pyright'] = function()
          lspconfig.pyright.setup {
            on_attach = on_attach,
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
