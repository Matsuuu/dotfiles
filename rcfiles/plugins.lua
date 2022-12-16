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
        commit = '3096e637c8d78fd9e9078f752dce2da2cc6d531e'
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

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Tellyscope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Theming
    -- use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    -- Webdev
    use 'jonsmithers/vim-html-template-literals'
    use 'ap/vim-css-color'
    use 'sbdchd/neoformat'

    -- Clojure
    -- Find out why this is being enabled in lua files
    --use 'Olical/conjure'
    use 'jiangmiao/auto-pairs'

    -- HTTP
    use 'NTBBloodbath/rest.nvim'

    --Random
    use 'tpope/vim-commentary'


end)
