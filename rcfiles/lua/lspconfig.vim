let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

call sign_define("LspDiagnosticsSignError", {"text" : "🔥", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "🚧", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "👷", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "🙋", "texthl" : "LspDiagnosticsHint"})

lua << END

vim.lsp.set_log_level("debug")

local lsp_status = require('lsp-status')
lsp_status.config({
  kind_labels = vim.g.completion_customize_lsp_label,
  current_function = false,
  status_symbol = '💬: ',
  indicator_errors = '🔥 ',
  indicator_warnings = '🚧 ',
  indicator_info = '👷 ',
  indicator_hint = '🙋 ',
  indicator_ok = '✅',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})
lsp_status.register_progress()

local on_attach_vim = function(client)
    --require'completion'.on_attach(client)
    lsp_status.on_attach(client)
    capabilities = lsp_status.capabilities
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup{ on_attach=on_attach_vim }
lspconfig.jsonls.setup{ on_attach=on_attach_vim }
lspconfig.html.setup{ on_attach=on_attach_vim }
--lspconfig.jdtls.setup{ on_attach=on_attach_vim }
lspconfig.cssls.setup{ on_attach=on_attach_vim }
lspconfig.clojure_lsp.setup{ on_attach=on_attach_vim }
lspconfig.gopls.setup { on_attach=on_attach_vim }
END
