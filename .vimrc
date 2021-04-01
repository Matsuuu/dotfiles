" --General ---
" Space is king
let mapleader = " "
let maplocalleader = " "

set exrc
set shortmess+=W
set termguicolors
syntax on
set backspace=indent,eol,start
set nocompatible
set nohlsearch
set ruler
set number
set nowrap
set showcmd
set incsearch
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
set scrolloff=8
set hidden
hi LinrNr term=NONE
filetype plugin indent on
"let g:loaded_matchparen=1


"--- Load plugins
source ~/.vim/rcfiles/plugins.vim

"--- Theming
autocmd ColorScheme * highlight LineNr ctermbg=NONE
autocmd ColorScheme * highlight clear SignColumn

" Pinkmare by me btw
colorscheme pinkmare

hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#87c095 guifg=NONE

"--- Source statusline
source ~/.vim/rcfiles/statusline.vim
"--- Source tabline
source ~/.vim/rcfiles/tabline.vim

set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" -- Dev icons for nerdtree
set encoding=UTF-8
" -- Open nerdtree on leader t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let NERDTreeShowHidden=1

"--- Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1

"--- Nvim lsp settings
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_trigger_on_delete = 1
let g:completion_trigger_keyword_length = 1

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

call sign_define("LspDiagnosticsSignError", {"text" : "🔥", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "🚧", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "👷", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "🙋", "texthl" : "LspDiagnosticsHint"})

"  _    _       _         _                   _          __  __ 
" | |  | |     | |       | |                 | |        / _|/ _|
" | |  | | __ _| |_   _  | |_   _  __ _   ___| |_ _   _| |_| |_ 
" | |  | |/ _` | | | | | | | | | |/ _` | / __| __| | | |  _|  _|
" | |__| | (_| | | |_| | | | |_| | (_| | \__ \ |_| |_| | | | |  
"  \____/ \__, |_|\__, | |_|\__,_|\__,_| |___/\__|\__,_|_| |_|  
"          __/ |   __/ |                                        
"         |___/   |___/                                         

if has('nvim')
lua << END
require('lspfuzzy').setup {}

vim.lsp.set_log_level("trace")

local lsp_status = require('lsp-status')
lsp_status.config({
  kind_labels = vim.g.completion_customize_lsp_label,
  current_function = false,
  status_symbol = '💬: ',
  indicator_errors = '🔥 ',
  indicator_warnings = '🚧 ',
  indicator_info = '👷 ',
  indicator_hint = '🙋 ',
  indicator_ok = '✅',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})
lsp_status.register_progress()

local on_attach_vim = function(client)
    require'completion'.on_attach(client)
    lsp_status.on_attach(client)
    capabilities = lsp_status.capabilities
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup{ on_attach=on_attach_vim }
lspconfig.jsonls.setup{ on_attach=on_attach_vim }
lspconfig.html.setup{ on_attach=on_attach_vim }
lspconfig.jdtls.setup{ on_attach=on_attach_vim }
lspconfig.cssls.setup{ on_attach=on_attach_vim }
lspconfig.clojure_lsp.setup{ on_attach=on_attach_vim }
lspconfig.gopls.setup { on_attach=on_attach_vim }

require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

END
endif

"  ______                         _   _   _             
" |  ____|                       | | | | (_)            
" | |__ ___  _ __ _ __ ___   __ _| |_| |_ _ _ __   __ _ 
" |  __/ _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
" | | | (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
" |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
"                                                  __/ |
"                                                 |___/

autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.clj lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.html Neoformat

"  _____                                
" |  __ \                               
" | |__) |___ _ __ ___   __ _ _ __  ___ 
" |  _  // _ \ '_ ` _ \ / _` | '_ \/ __|
" | | \ \  __/ | | | | | (_| | |_) \__ \
" |_|  \_\___|_| |_| |_|\__,_| .__/|___/
"                            | |        
"                            |_|
"
"Format, fucker
nnoremap <silent>ff    <cmd>Neoformat<CR>
"Go to Ref
nnoremap <silent>gr    <cmd>lua vim.lsp.buf.references()<CR>
"Go to Def
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader><CR>  <cmd>lua vim.lsp.buf.code_action()<CR>
"ReName
nnoremap <Leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
"Explain error
nnoremap <Leader>ee    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
"Show error
nnoremap <Leader>se    <cmd>lua vim.lsp.diagnostic.goto_next { wrap = true }<CR>

nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>


nnoremap <C-n> :Files<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <Leader>h+ :horizontal resize +5<CR>
nnoremap <silent> <Leader>h- :horizontal resize -5<CR>

" Search
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nnoremap <C-F> :Rg <CR>
nnoremap <C-B> :Buffers <CR>
nnoremap <C-H> :History <CR>
nnoremap <Leader>pf <C-^>
" Tabbing autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"terminal remap
tnoremap <Esc> <C-\><C-n>

imap <silent> <c-p> <Plug>(completion_trigger)
