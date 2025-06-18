-- If this module doesn't load, comment out the actions and theme accesses...
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
                layout_strategy = "vertical",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--ignore",
					"--hidden",
				},
				file_ignore_patterns = {
					".git",
					"node_modules",
				},
				prompt_prefix = "🔎 ",
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<esc>"] = require("telescope.actions").close,
					},
				},
			},
			pickers = {
				lsp_code_actions = {
					theme = "cursor",
				},
				code_action = {
					theme = "cursor",
				},
				lsp_workspace_diagnostics = {
					theme = "dropdown",
				},
				live_grep = {
					layout_strategy = "vertical",
				},
				oldfiles = {
					layout_strategy = "vertical",
				},
				find_files = {
					layout_strategy = "vertical",
					find_command = { "rg", "--files", "--hidden", "--ignore" },
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_cursor({
						-- even more opts
					}),
				},
			},
		})
	end,
	init = function()
		require("telescope").load_extension("ui-select")
	end,
	keys = {
		{
			"<C-N>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<C-F>",
			function()
				require("telescope.builtin").live_grep()
			end,
			"Live grep",
		},
		{
			"F",
			function()
				require("telescope.builtin").resume()
			end,
			"Resume",
		},
		{
			"<C-L>",
			function()
				require("telescope.builtin").buffers()
			end,
			"Show buffers",
		},
		{
			"<C-H>",
			function()
				require("telescope.builtin").oldfiles()
			end,
			"Show Old files",
		},
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references()
			end,
			"Show LSP references",
		},
		{
			"<Leader>gs",
			function()
				require("telescope.builtin").git_status()
			end,
			"Show Git status",
		},
		{
			"<Leader>sd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			"Show diagnostics",
		},
		{
			"<Leader>r",
			function()
				require("telescope.builtin").resume()
			end,
			"Resume previous query",
		},
		{
			"<C-k>",
			function()
				require("telescope.actions").move_selection_previous()
			end,
			"Navigate up in list",
		},

		--         ["<C-k>"] = require("telescope.actions").move_selection_previous,
		--         ["<C-j>"] = require("telescope.actions").move_selection_next,
	},
}
