return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.25,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "stacks",
								size = 0.25,
							},
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{
								id = "repl",
								size = 1,
							},
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})

			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Debug (Attach) - Remote",
					hostName = "localhost",
					port = "5005",
				},
			}

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign(
				"DapBreakpointCondition",
				{ text = "🔴", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapStopped", { text = "🔴", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
			vim.keymap.set("n", "<space>dt", function()
				ui.toggle({ reset = true })
			end)

			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F9>", dap.continue)
			vim.keymap.set("n", "<F7>", dap.step_into)
			vim.keymap.set("n", "<F8>", dap.step_over)
			vim.keymap.set("n", "<S-F8>", dap.step_out)
			vim.keymap.set("n", "<F12>", dap.restart)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
