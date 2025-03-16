return {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {},
    dependencies = {
        -- { "echanovski/mini.icons", opts = {} }
    },
    lazy = false,
    config = function ()
        require("oil").setup({
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set('n', '-', '<cmd>Oil<CR>')
        vim.keymap.set('n', '<leader>-', require("oil").toggle_float)
    end
}
