-- If this module doesn't load, comment out the actions and theme accesses...
return  {
    "nvim-telescope/telescope.nvim",
    keys = {
        {
            "<C-N>",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files",
        },
        {
            "<C-F>",
            function() require("telescope.builtin").live_grep() end,
            "Live grep"
        },
        {
            "<C-L>",
            function() require("telescope.builtin").buffers() end,
            "Show buffers"
        },
        {
            "<C-H>",
            function() require("telescope.builtin").oldfiles() end,
            "Show Old files"
        },
        {
            "gr",
            function() require("telescope.builtin").lsp_references() end,
            "Show LSP references"
        },
        {
            "<Leader>gs",
            function() require("telescope.builtin").git_status() end,
            "Show Git status"
        },
        {
            "<Leader>sd",
            function() require("telescope.builtin").diagnostics() end,
            "Show diagnostics"
        },
    },
    -- change some options
    opts = {
        defaults = {
            layout_config = {
                vertical = { width = 0.8 }
            },
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--ignore',
                '--hidden'
            },
            file_ignore_patterns = {
                ".git",
                "node_modules"
            },
            prompt_prefix = "🔎 ",
            mappings = {
                i = {
                    ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    ["<C-j>"] = require("telescope.actions").move_selection_next,
                    ["<esc>"] = require("telescope.actions").close
                }
            }
        },
        pickers = {
            lsp_code_actions = {
                theme = "cursor"
            },
            code_action = {
                theme = "cursor"
            },
            lsp_workspace_diagnostics = {
                theme = "dropdown"
            },
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--ignore" }
            }
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_cursor {
                -- even more opts
                }
            }
        }
    }
}
