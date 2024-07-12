return {
    "nvim-lua/lsp-status.nvim",
    init = function () 
        local signs = {
            { name = "DiagnosticSignError", text = "🔥" },
            { name = "DiagnosticSignWarn", text = "🚧" },
            { name = "DiagnosticSignHint", text = "👷" },
            { name = "DiagnosticSignInfo", text = "🙋" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

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
    end
}
