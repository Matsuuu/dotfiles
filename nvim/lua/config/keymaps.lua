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
