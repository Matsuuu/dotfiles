" --General ---
" Space is king
let mapleader = " "

set shortmess+=W
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


"--- Load plugins
source ~/.vim/rcfiles/plugins.vim

"--- Theming
autocmd ColorScheme * highlight LineNr ctermbg=NONE
autocmd ColorScheme * highlight clear SignColumn
colorscheme pinkmare

"--- Source statusline
source ~/.vim/rcfiles/statusline.vim


set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" -- Dev icons for nerdtree
set encoding=UTF-8
" -- Open nerdtree on leader t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 0
let NERDTreeShowHidden=1

"--- Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1

"--- Nvim lsp settings
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

call sign_define("LspDiagnosticsSignError", {"text" : "🔥", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "🚧", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "👷", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "🙋", "texthl" : "LspDiagnosticsHint"})

""--- Lang servers
if has('nvim')
lua << EOF
require('lspfuzzy').setup {}
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

local lsp_status = require('lsp-status')
lsp_status.register_progress()
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

local on_attach_vim = function(client)
    require'completion'.on_attach(client)
    lsp_status.on_attach(client)
    capabilities = lsp_stats.capabilities
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach_vim }
require'lspconfig'.jsonls.setup{ on_attach=on_attach_vim }
require'lspconfig'.html.setup{ on_attach=on_attach_vim }
require'lspconfig'.jdtls.setup{ on_attach=on_attach_vim }
require'lspconfig'.cssls.setup{ on_attach=on_attach_vim }
require'lspconfig'.clangd.setup{ on_attach=on_attach_vim }
require'lspconfig'.intelephense.setup{ on_attach=on_attach_vim }

EOF
end
"--- Formatting
autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.html Neoformat


" ---- Remaps
"
nnoremap <silent>ff    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader><CR>  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>


nnoremap <C-n> :Files<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <Leader>h+ :horizontal resize +5<CR>
nnoremap <silent> <Leader>h- :horizontal resize -5<CR>
nnoremap <C-F> :Rg <CR>
nnoremap <C-B> :Buffers <CR>
nnoremap <C-H> :History <CR>
nnoremap <Leader>pf <C-^>
" Tabbing autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

imap <silent> <c-p> <Plug>(completion_trigger)
