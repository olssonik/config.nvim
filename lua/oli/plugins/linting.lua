return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
    local linters = require("lint").linters

		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			python = {"flake8"},
      go = { "golangcilint" }, -- Go linter
			c = { "cpplint" },         -- C linter
			cpp = { "cpplint" },       -- C++ linter
			dockerfile = { "hadolint" }, -- Docker linter
      json = {'jsonlint'},
      sql = {'sqlfluff'},
      markdown = {'markdownlint'},
		}
    linters.flake8.args = {'--max-line-length=160',}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "ModeChanged" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
