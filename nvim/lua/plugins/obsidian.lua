return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter"
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
      {
        name = "personal-win",
        path = "/mnt/c/Users/MatiasHuhta/vaults/personal"
      },
      {
        name = "work",
        path = "/mnt/c/Users/MatiasHuhta/vaults/work"
      },
    },
  },
    -- config = function(_, opts)
    --     require("obsidian").setup(opts)
    -- end
}
