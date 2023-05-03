vim.gdiagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = ' '

local signs = {
	{ name = "DiagnosticSignError", text = "🔥" },
	{ name = "DiagnosticSignWarn", text = "🚧" },
	{ name = "DiagnosticSignHint", text = "👷" },
	{ name = "DiagnosticSignInfo", text = "🙋" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Show diagnostic when hovering
--vim.o.updatetime = 250
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


vim.lsp.set_log_level("trace")

local lsp_status = require('lsp-status')
lsp_status.config({
  kind_labels = vim.g.completion_customize_lsp_label,
  current_function = false,
  status_symbol = '',
  indicator_errors = '🔥 ',
  indicator_warnings = '🚧 ',
  indicator_info = '🙋 ',
  indicator_hint = '👷 ',
  indicator_ok = '✅',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})
lsp_status.register_progress()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach_vim = function(client)
    lsp_status.on_attach(client)
    capabilities = lsp_status.capabilities
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup{ on_attach=on_attach_vim, capabilities = capabilities }
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
lspconfig.custom_elements_languageserver.setup { on_attach=on_attach_vim, capabilities = capabilities }
