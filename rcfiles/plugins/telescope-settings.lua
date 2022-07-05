local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
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
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<esc>"] = actions.close
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
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap("n", "<C-F>", "<cmd>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<cmd>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-N>", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-H>", "<cmd>Telescope oldfiles <CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader><CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<silent>gr", "<cmd>Telescope lsp_references<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>gs", "<cmd>Telescope git_status<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>sd", "<cmd>Telescope diagnostics<CR>", { noremap = true })

--nnoremap <C-F> <cmd>Telescope live_grep<CR>
--" God damn tmux taking the C-B bind
--nnoremap <C-L> <cmd>Telescope buffers<CR>
--nnoremap <C-N> <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
--nnoremap <C-H> <cmd>Telescope oldfiles<CR>
--nnoremap <Leader><CR> <cmd>lua vim.lsp.buf.code_action()<CR>
--nnoremap <silent>gr    <cmd>Telescope lsp_references<CR>
--nnoremap <Leader>gs    <cmd>Telescope git_status<CR>
--" Show diagnostics
--nnoremap <Leader>sd <cmd>Telescope diagnostics<CR>
-- 
vim.cmd([[
  highlight TelescopeSelection guifg=#FF38A2 gui=bold
  highlight TelescopeMatching guifg=#d9bcef
]])
