local signs = {
	DiagnosticSignError = "🔥",
	DiagnosticSignWarn = "🚧",
	DiagnosticSignHint = "👷",
	DiagnosticSignInfo = "🙋",
}

local foo = "bar"

for name, icon in pairs(signs) do
	vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
end
