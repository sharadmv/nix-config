local utils = require('utils')

utils.map('', ';', ':', { noremap = false, silent = true })
utils.map('n', ';;', ';', { noremap = true, silent = true })

-- General keybinds
utils.map('n', '<C-h>', '<C-w><C-h>')
utils.map('n', '<C-j>', '<C-w><C-j>')
utils.map('n', '<C-k>', '<C-w><C-k>')
utils.map('n', '<C-l>', '<C-w><C-l>')

-- LSP keybinds
utils.map('n', '<leader>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.map('n', '<leader>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
utils.map('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>')
utils.map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
utils.map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
utils.map('n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- Telescope
utils.map('n', '<C-p>', '<cmd>lua require("plugins/telescope").project_files()<CR>')
utils.map('n', '<C-i>', '<cmd>Telescope live_grep<CR>')
utils.map('n', '<C-u>', '<cmd>Telescope buffers<CR>')

-- Vista
utils.map('n', '<C-y>', '<cmd>Vista finder<CR>')
utils.map('n', '<M-/>', '<cmd>Vista!!<CR>')

-- Tree
utils.map('n', '<C-e>', ':NvimTreeToggle<CR>')
