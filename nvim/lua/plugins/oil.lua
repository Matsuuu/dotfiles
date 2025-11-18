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
        local oil = require("oil")
		oil.setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},

            -- keymaps
              keymaps = {
                -- ['<C-t>'] = oil.select({ close = true, tab = true }),
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

        vim.api.nvim_create_autocmd("User", {
          pattern = "OilEnter",
          callback = vim.schedule_wrap(function(args)
            local oil = require("oil")
            if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
              oil.open_preview()
            end
          end),
        })

        local oil = require("oil")

		vim.keymap.set("n", "-", function ()
            oil.open(nil, {
                preview = {
                    vertical = true
                }
            })
        end)
	end,
}
