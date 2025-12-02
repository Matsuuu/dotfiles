vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = " "

return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local on_attach_vim = function(client) end

		local lspconfig = require("lspconfig")

        vim.lsp.enable("ts_ls")
        vim.lsp.enable("jsonls")
        vim.lsp.enable("html")
        vim.lsp.enable("cssls")
        vim.lsp.enable("clojure_lsp")
        vim.lsp.enable("gopls")

        vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
					},
				},
			},
		})
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("pyright")
        vim.lsp.enable("tailwindcss")

        vim.lsp.config("sqls", {
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = "postgresql",
                            dataSourceName = "host=127.0.0.1 port=5432 user=test password=test dbname=test_db sslmode=disable"
                        }
                    }
                }
            }
        })
        vim.lsp.enable("sqls")
        vim.lsp.enable("astro")
        vim.lsp.enable("wc")


	end,
}
