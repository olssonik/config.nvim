vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- reload file if changed outside but buffer open
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'FocusGained', 'VimResume' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})

    local keymap = vim.keymap
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = 'Show LSP references'
    keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

    opts.desc = 'Go to declaration'
    keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = 'Show LSP definitions'
    keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

    opts.desc = 'Show LSP implementations'
    keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

    opts.desc = 'Show LSP type definitions'
    keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

    opts.desc = 'See available code actions'
    keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = 'Smart rename'
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = 'Show buffer diagnostics'
    keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

    opts.desc = 'Show line diagnostics'
    keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = 'Go to previous diagnostic'
    keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = 'Go to next diagnostic'
    keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = 'Show documentation for what is under cursor'
    keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = 'Restart LSP'
    keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
  end,
})
