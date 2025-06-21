return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    local linters = require('lint').linters

    lint.linters_by_ft = {
      javascript = { 'biomejs' },
      typescript = { 'biomejs' },
      javascriptreact = { 'biomejs' },
      typescriptreact = { 'biomejs' },
      python = { 'flake8' },
      go = { 'golangcilint' }, -- Go linter
      c = { 'cpplint' }, -- C linter
      cpp = { 'cpplint' }, -- C++ linter
      dockerfile = { 'hadolint' }, -- Docker linter
      json = { 'jsonlint' },
      sql = { 'sqlfluff' },
      markdown = { 'markdownlint' },
    }

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
