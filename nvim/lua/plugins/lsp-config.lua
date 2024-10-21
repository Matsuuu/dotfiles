vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = ' '


return {
    "neovim/nvim-lspconfig",
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function() 
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local lsp_status = require("lsp-status")

        local on_attach_vim = function(client)
            lsp_status.on_attach(client)
            capabilities = lsp_status.capabilities
        end

        local lspconfig = require('lspconfig')

        lspconfig.ts_ls.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.jsonls.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.html.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.cssls.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.clojure_lsp.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.gopls.setup { on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.lua_ls.setup {
            on_attach=on_attach_vim,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
        lspconfig.rust_analyzer.setup{ on_attach=on_attach_vim, capabilities = capabilities }
        -- lspconfig.custom_elements_ls.setup { on_attach=on_attach_vim, capabilities = capabilities }
        lspconfig.pyright.setup{}
        lspconfig.jdtls.setup{
            jdtls = function()
                return true --avoid duplicates
            end,
        }
    end
}
