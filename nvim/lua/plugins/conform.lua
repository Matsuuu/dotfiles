vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local frontend_formatters = { "biome", "prettier", "prettierd", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			-- Conform will run the first available formatter
			javascript = frontend_formatters,
			javascriptreact = frontend_formatters,
			typescript = frontend_formatters,
			typescriptreact = frontend_formatters,
			css = frontend_formatters,
			html = frontend_formatters,
			json = frontend_formatters,
			yaml = frontend_formatters,
			go = { "gofmt", stop_after_first = true },
			templ = { "templ", stop_after_first = true },

			terraform = { "terraform_fmt" },
			lua = { "stylua" },
		},
	},

	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ async = true, lsp_format = "never" })
			end,
			mode = "",
			desc = "[Ff]ormat buffer",
		},
	},
}
