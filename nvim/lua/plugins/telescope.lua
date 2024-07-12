return  {
    "nvim-telescope/telescope.nvim",
    keys = {
        {
            "<C-N>",
            function() require("telescope.builtin").find_files({}) end,
            desc = "Find files",
        },
        {
            "<C-F>",
            function() require("telescope.builtin").live_grep({}) end,
            "Live grep"
        }
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
