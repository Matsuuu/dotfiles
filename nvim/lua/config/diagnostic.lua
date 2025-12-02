local signs = {
	DiagnosticSignError = "🔥",
	DiagnosticSignWarn = "🚧",
	DiagnosticSignHint = "👷",
	DiagnosticSignInfo = "🙋",
}

vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return signs.DiagnosticSignError
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return signs.DiagnosticSignWarn
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                return signs.DiagnosticSignInfo
            else
                return signs.DiagnosticSignHint
            end
        end,
    },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.DiagnosticSignError,
			[vim.diagnostic.severity.WARN] = signs.DiagnosticSignWarn,
			[vim.diagnostic.severity.INFO] = signs.DiagnosticSignInfo,
			[vim.diagnostic.severity.HINT] = signs.DiagnosticSignHint,
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
