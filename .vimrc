" --General ---
" Space is king
let mapleader = " "

set backspace=indent,eol,start
set nocompatible              
set ruler
set number
set nowrap
set showcmd
set incsearch
set hlsearch
set noswapfile
set autoread
set ignorecase
set smartcase
set noerrorbells
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set cursorline
set backupcopy=yes
set relativenumber
hi LinrNr term=NONE
syntax on
filetype plugin indent on

"--- Load plugins
source ~/.vim/rcfiles/plugins.vim

let g:coc_start_at_startup = 1
set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

"--- Theming
autocmd ColorScheme * highlight LineNr ctermbg=NONE
autocmd ColorScheme * highlight clear SignColumn
let g:miramare_transparent_background=1
colorscheme miramare

" -- Dev icons for nerdtree
set encoding=UTF-8
" -- Open nerdtree on leader t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 0

"-- Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='miramare'
let g:airline#extensions#tabline#enabled = 1

"--- Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1

" ---- Remaps

nnoremap <C-n> :Files<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
" This was conflicting with some other binds. 
" Check on Alacritty if it was it or urxvt
nnoremap <C-l> <C-i>
nnoremap <C-F> :Rg <CR>
nnoremap <Leader>pf <C-^>
