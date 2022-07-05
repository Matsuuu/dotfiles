vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Themes
    use 'matsuuu/pinkmare'

    -- Trees n shit
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'

    -- Functional
    use 'scrooloose/nerdtree'
    use 'tpope/vim-fugitive'
    use 'jistr/vim-nerdtree-tabs'
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

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Tellyscope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Theming
    use 'ryanoasis/vim-devicons'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'

    -- Webdev
    use 'jonsmithers/vim-html-template-literals'
    use 'ap/vim-css-color'
    use 'sbdchd/neoformat'

    -- Clojure
    use 'Olical/conjure'
    use 'jiangmiao/auto-pairs'

    -- HTTP
    use 'NTBBloodbath/rest.nvim'

    --Random
    use 'tpope/vim-commentary'


end)
