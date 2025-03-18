
-- These require manual installation
local ensure_installed = {
    "jdtls",
    "java-debug-adapter",
    "java-test",
    "tailwindcss-language-server",
    "terraform-ls",
    "lua-language-server",
    "prettier",
    "typescript-language-server",
    "html-lsp",
    "css-lsp",
}


vim.api.nvim_create_user_command("MasonInstallAll", function()
    for _, server in ipairs(ensure_installed) do
        -- require("mason").install(server)
        vim.cmd("MasonInstall " .. server)
    end
end, {})

return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({})

	end,
}
