return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Import all the plugins we need here
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Get the lspconfig capabilities, which we'll pass to every server
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup mason itself
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup mason-tool-installer to install formatters and linters
    mason_tool_installer.setup({
      ensure_installed = { "prettier", "stylua", "black", "isort", "flake8" },
    })

    -- This is the new, unified setup for mason-lspconfig
    mason_lspconfig.setup({
      -- A list of LSPs to install automatically
      ensure_installed = {
        "pyright",
        "lua_ls",
        "cssls",
        "html",
        "gopls",
        "jsonls",
        "ts_ls",
      },
      -- This handlers block configures lspconfig for each server
      handlers = {
        -- This is a default handler that will apply to all servers
        -- that don't have a specific handler below.
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- This is the custom handler for Pyright with our corrected settings.
        ["pyright"] = function()
          lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
              pyright = {
                analysis = {
                  -- This enables full project analysis
                  diagnosticMode = "workspace",
                  -- This enables strict type checking for errors like "None" is not assignable
                  typeCheckingMode = "strict",
                },
              },
            },
          })
        end,
      },
    })
  end,
}
