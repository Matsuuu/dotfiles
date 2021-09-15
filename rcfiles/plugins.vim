" Get Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"--- Themes
Plug 'matsuuu/pinkmare'

"--- Trees n shit
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

"--- Functional
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

"--- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'onsails/lspkind-nvim'

"--- Tellyscope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"--- Theming
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"--- Markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install' }

"--- Webdev
Plug 'jonsmithers/vim-html-template-literals'
Plug 'ap/vim-css-color'
Plug 'sbdchd/neoformat'

"--- Clojure
Plug 'Olical/conjure', {'tag': 'v4.14.1'}
Plug 'jiangmiao/auto-pairs'

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutBackInsert = '<M-0>'

"--- Sources
source ~/.vim/rcfiles/javascript.vim
source ~/.vim/rcfiles/java.vim
source ~/.vim/rcfiles/clojure.vim

call plug#end()
