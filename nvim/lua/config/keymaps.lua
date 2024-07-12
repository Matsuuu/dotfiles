vim.api.nvim_set_keymap("n", "<Leader>+", ":vertical resize +5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>-", ":vertical resize -5<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>bn", ":bn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>bp", ":bp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>bh", ":bn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>bl", ":bp<CR>", { noremap = true })

-- Undo breakpoints
vim.api.nvim_set_keymap("i", ",", ",<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ".", ".<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "!", "!<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "?", "?<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ":", ":<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ";", ";<c-g>u", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>pf", "<C-^>", { noremap = true })

vim.api.nvim_set_keymap("n", "'", "%", { noremap = true })
vim.api.nvim_set_keymap("v", "'", "%", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>rc", ":source ~/.config/nvim/init.lua", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader><CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<silent>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<silent>gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<silent>K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<silent><C-p>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>ee", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>se", "<cmd>lua vim.diagnostic.goto_next({ wrap = true })<CR>", { noremap = true })
