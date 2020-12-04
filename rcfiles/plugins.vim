" Get Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"--- Themes
Plug 'gruvbox-community/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'franbach/miramare'
Plug 'connorholyday/vim-snazzy'

"--- Functional
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

"--- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"--- Theming
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"--- Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install' }

"--- Webdev
Plug 'herringtondarkholme/yats.vim'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'sbdchd/neoformat'

"--- Java
Plug 'uiiaoo/java-syntax.vim'

"--- Other
Plug 'sheerun/vim-polyglot'



"--- Sources
source ~/.vim/rcfiles/javascript.vim
source ~/.vim/rcfiles/java.vim

" -- FZF
source ~/.fzf/plugin/fzf.vim

call plug#end()
