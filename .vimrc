" --General ---
" Space is king
let mapleader = " "

set termguicolors
syntax on
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
set signcolumn=yes
hi LinrNr term=NONE
filetype plugin indent on
let g:loaded_matchparen=1


"--- Theming
autocmd ColorScheme * highlight LineNr ctermbg=NONE
autocmd ColorScheme * highlight clear SignColumn
"let g:miramare_transparent_background=1
colorscheme miramare

"--- Load plugins
source ~/.vim/rcfiles/plugins.vim

"let g:coc_start_at_startup = 1
set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

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

"--- Nvim lsp settings
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


lua << EOF
local on_attach_vim = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

require'nvim_lsp'.tsserver.setup{ on_attach=on_attach_vim }
require'nvim_lsp'.jdtls.setup{ on_attach=on_attach_vim }
require'nvim_lsp'.jsonls.setup{ on_attach=on_attach_vim }
require'nvim_lsp'.html.setup{ on_attach=on_attach_vim }
require'nvim_lsp'.cssls.setup{ on_attach=on_attach_vim }

EOF
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "💡", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

nnoremap <silent>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader><CR>  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>

" ---- Remaps

nnoremap <C-n> :Files<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <C-F> :Rg <CR>
nnoremap <Leader>pf <C-^>
" Tabbing autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

