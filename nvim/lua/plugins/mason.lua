return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({})
	end,
	opts = {
		ensure_installed = {
			"jdtls",
			"java-debug-adapter",
			"java-test",
			"tailwindcss-language-server",
			"terraform-ls",
		},
	},
}
