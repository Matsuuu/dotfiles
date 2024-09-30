vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

return {
  'stevearc/conform.nvim',
  opts = {
        formatters_by_ft = {
            -- Conform will run the first available formatter
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        }
    },
}

