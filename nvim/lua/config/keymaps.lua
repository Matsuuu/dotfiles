vim.keymap.set("n", "<Leader>+", ":vertical resize +5<CR>")
vim.keymap.set("n", "<Leader>-", ":vertical resize -5<CR>")

vim.keymap.set("n", "<Leader>bn", ":bn<CR>")
vim.keymap.set("n", "<Leader>bp", ":bp<CR>")
vim.keymap.set("n", "<Leader>bh", ":bh<CR>")
vim.keymap.set("n", "<Leader>bl", ":bl<CR>")

-- Undo breakpoints
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ":", ":<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Leader>pf", "<C-^>")

vim.keymap.set("n", "'", "%")
vim.keymap.set("v", "'", "%")

vim.keymap.set("n", "<Leader>rc", ":source ~/.config/nvim/init.lua<CR>")

vim.keymap.set("n", "<Leader><CR>", vim.lsp.buf.code_action)

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<Leader>ee", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>se", function()
	vim.diagnostic.goto_next({ wrap = true })
end)

vim.keymap.set("n", "<Leader>y", '"+y')
vim.keymap.set("v", "<Leader>y", '"+y')

vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
