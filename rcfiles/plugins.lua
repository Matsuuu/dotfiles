vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Themes
    use 'matsuuu/pinkmare'

    -- Trees n shit
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use 'nvim-treesitter/playground'

    -- Functional
    use 'tpope/vim-fugitive'
    use 'alvan/vim-closetag'
    use 'tpope/vim-surround'
    use 'szw/vim-maximizer'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'mfussenegger/nvim-jdtls'

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'saadparwaiz1/cmp_luasnip'
    use {
      'kkoomen/vim-doge',
      run = ':call doge#install()'
    }

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Tellyscope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Theming
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    -- Webdev
    use 'jonsmithers/vim-html-template-literals'
    use 'ap/vim-css-color'
    use 'sbdchd/neoformat'

    -- Clojure
    -- Find out why this is being enabled in lua files
    use 'Olical/conjure'
    use 'jiangmiao/auto-pairs'

    -- HTTP
    use 'NTBBloodbath/rest.nvim'

    --Random
    use 'tpope/vim-commentary'
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          window = {
              backdrop = 1,
              width = 200,
          },
          plugins = {
              alacritty = {
                  enabled = false,
                  font = "20", -- font size
              },
          }
        }
      end
    }

    -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

end)
