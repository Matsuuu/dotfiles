return {
	"stevearc/oil.nvim",
	---@module "oil"
	---@type oil.SetupOpts
	opts = {},
	dependencies = {
		-- { "echanovski/mini.icons", opts = {} }
	},
	lazy = false,
	config = function()
		require("oil").setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			-- Configuration for the file preview window
			preview_win = {
				-- Whether the preview window is automatically updated when the cursor is moved
				update_on_cursor_moved = true,
				-- How to open the preview window "load"|"scratch"|"fast_scratch"
				preview_method = "fast_scratch",
				-- A function that returns true to disable preview on a file e.g. to avoid lag
				disable_preview = function(filename)
					return false
				end,
				-- Window-local options to use for preview window buffers
				win_options = {},
			},
		})

		vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
	end,
}
