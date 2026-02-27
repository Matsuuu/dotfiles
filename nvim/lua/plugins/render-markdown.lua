return {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        completions = { lsp = { enabled = true } },

        checkbox = {
        unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'.
            icon = '󰄱 ',
            -- Highlight for the unchecked icon.
            highlight = 'RenderMarkdownUnchecked',
            -- Highlight for item associated with unchecked checkbox.
            scope_highlight = nil,
        },
        checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'.
            icon = '☑',
            -- Highlight for the checked icon.
            highlight = 'RenderMarkdownChecked',
            -- Highlight for item associated with checked checkbox.
            scope_highlight = nil,
        },
    },
    },
}
