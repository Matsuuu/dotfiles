local signs = {
	DiagnosticSignError = "🔥",
	DiagnosticSignWarn = "🚧",
	DiagnosticSignHint = "👷",
	DiagnosticSignInfo = "🙋",
}

vim.diagnostic.config({
	virtual_text = true,
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
