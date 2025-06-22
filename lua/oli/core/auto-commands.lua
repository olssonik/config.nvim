vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- reload file if changed outside but buffer open
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'FocusGained', 'VimResume' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})
