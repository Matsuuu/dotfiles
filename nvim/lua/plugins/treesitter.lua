return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        -- Optional custom install directory:
        -- install_dir = vim.fn.stdpath("data") .. "/site",
      })

      ------------------------------------------------------------------------
      -- Install parsers automatically
      ------------------------------------------------------------------------
      local languages = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "vue",
        "css",
        "scss",
      }

      ts.install(languages)

        local extra_languages = {
            "typescriptreact",
        }

        for k,v in ipairs(extra_languages) do
            table.insert(languages, v)
        end

      ------------------------------------------------------------------------
      -- Enable Tree-sitter highlighting
      ------------------------------------------------------------------------
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
        end,
      })

      ------------------------------------------------------------------------
      -- Enable Tree-sitter indentation (experimental)
      ------------------------------------------------------------------------
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "python", "javascript", "typescript" },
        callback = function()
          vim.bo.indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
}
