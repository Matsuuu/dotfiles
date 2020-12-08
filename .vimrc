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

set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" -- Dev icons for nerdtree
set encoding=UTF-8
" -- Open nerdtree on leader t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 0
let NERDTreeShowHidden=1

"-- Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='miramare'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ""
let g:airline#extensions#tabline#right_sep = ""
let g:airline_left_sep = "  "
let g:airline_right_sep = "  "
let g:airline_skip_empty_sections = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_disable_statusline = 1

" Change airline positions
function! AirlineInit()
  "let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_a = "aaaa"
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" ------ Statusline

let left = ''
let right = ''

set laststatus=2

set statusline=
set statusline=%9*
set statusline+=%=
"Status

hi StatusBarColor guibg=#2f3337 guifg=white
hi StatusBalloonColor guifg=#273337
au InsertEnter * hi StatusBarColor guibg=#e68183 guifg=#2a2426
au InsertEnter * hi StatusBalloonColor guifg=#e68183
au InsertLeave * hi StatusBarColor guibg=#2f3337 guifg=white
au InsertLeave * hi StatusBalloonColor guifg=#273337

set statusline+=%#StatusBalloonColor#
set statusline+=%{left}
set statusline+=%#StatusBarColor#
set statusline+=\ \ 
set statusline+=%{StatuslineMode()}
set statusline+=\ \ 
set statusline+=%#StatusBalloonColor#

set statusline+=%{right}%9*
set statusline+=%=

"Git
set statusline+=%4*%{left}%2*\ \ 
set statusline+=%{FugitiveHead()}
set statusline+=\ %4*%{right}%9*
set statusline+=%=
"Filename
set statusline+=%4*%{left}%2*\ \ 
set statusline+=%.20F
set statusline+=\ \ 
set statusline+=%3*
set statusline+=\ \ 
"Lines
set statusline+=%l/%L
"Column
set statusline+=\|
set statusline+=%c
set statusline+=\ \ %5*%{right}%9*
set statusline+=%=
set statusline+=%4*%{left}%2*\ 
"Filetype
set statusline+=%y
set statusline+=\ %4*%{right}%9*
set statusline+=%=

hi User1 guibg=green guifg=white
" Balloon
hi User2 guibg=#2f3337 guifg=white
" Alt balloon
hi User3 guibg=#3e4347 guifg=white
" For rounders
hi User4 guifg=#2f3337 
" Alt rounders
hi User5 guifg=#3e4347 
" Clear
hi User9 guifg=white 

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

"--- Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1

"--- Nvim lsp settings
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

"call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignError", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
"call sign_define("LspDiagnosticsWarningSign", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
"call sign_define("LspDiagnosticsInformationSign", {"text" : "💡", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "💡", "texthl" : "LspDiagnosticsInformation"})
"call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
call sign_define("LspDiagnosticsSignHint", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

""--- Lang servers
lua << EOF
local on_attach_vim = function(client)
    require'completion'.on_attach(client)
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach_vim }
require'lspconfig'.jsonls.setup{ on_attach=on_attach_vim }
require'lspconfig'.html.setup{ on_attach=on_attach_vim }
require'lspconfig'.jdtls.setup{ on_attach=on_attach_vim }
require'lspconfig'.cssls.setup{ on_attach=on_attach_vim }
require'lspconfig'.clangd.setup{ on_attach=on_attach_vim }
require'lspconfig'.intelephense.setup{ on_attach=on_attach_vim }

EOF

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
nnoremap <Leader>pf <C-^>
" Tabbing autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

imap <silent> <c-p> <Plug>(completion_trigger)
