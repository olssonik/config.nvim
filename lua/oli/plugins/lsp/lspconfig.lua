-- lua/oli/plugins/lsp/lspconfig.lua
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim', -- <-- This is the corrected line
    'hrsh7th/cmp-nvim-lsp',
    'folke/neodev.nvim',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local keymap = vim.keymap
    vim.diagnostic.config {
      virtual_text = true, -- Show error messages at the end of the line
      signs = true, -- Show icons in the sign column
      underline = true, -- Underline the code with errors
      update_in_insert = false, -- Don't update diagnostics in insert mode (for performance)
      severity_sort = true, -- Sort diagnostics by severity
    }
    -- All your keymaps and autocmds go here as before...
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
    }
  end,
}
