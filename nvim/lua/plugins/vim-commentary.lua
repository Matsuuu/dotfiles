vim.api.nvim_set_keymap("v", "<Leader>cc", ":Commentary<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>cs", "{v}:Commentary<CR>", { noremap = true })

return {
    "tpope/vim-commentary"
}
