" Get Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install' }

Plug 'herringtondarkholme/yats.vim'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'

Plug 'uiiaoo/java-syntax.vim'

"--- Sources
source ~/.vim/rcfiles/javascript.vim
source ~/.vim/rcfiles/java.vim
source ~/.vim/rcfiles/coc.vim

"--- Themes
Plug 'gruvbox-community/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'franbach/miramare'

" -- FZF
source ~/.fzf/plugin/fzf.vim

call plug#end()

