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
"set completeopt=menuone,noinsert,noselect
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"let g:completion_trigger_on_delete = 1
"let g:completion_trigger_keyword_length = 1

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
--vim.lsp.set_log_level("debug")

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
    --require'completion'.on_attach(client)
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

local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--ignore',
            '--hidden'
        },
        file_ignore_patterns = {
            ".git",
            "node_modules"
        },
        prompt_prefix = "🔎 ",
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<esc>"] = actions.close
            }
        }
    }
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})

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
nnoremap <silent>ff    <cmd>Neoformat<CR><Esc>:w<CR>
"Go to Def
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>
" Docs pls
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
" Params pls
inoremap <silent><C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
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

"
"             _
"           /(_))
"         _/   /
"        //   /
"       //   /
"       /\__/
"       \O_/=-.
"   _  / || \  ^o
"   \\/ ()_) \.
"    ^^ <__> \()
"      //||\\
"     //_||_\\  ds
"    // \||/ \\
"   //   ||   \\
"  \/    |/    \/
"  /     |      \
" /      |       \
"        |
"
nnoremap <C-F> <cmd>Telescope live_grep<CR>
nnoremap <C-B> <cmd>Telescope buffers<CR>
nnoremap <C-N> <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
nnoremap <C-H> <cmd>Telescope oldfiles<CR>
nnoremap <Leader><CR> <cmd>Telescope lsp_code_actions<CR>
nnoremap <silent>gr    <cmd>Telescope lsp_references<CR>
nnoremap <Leader>gs    <cmd>Telescope git_status<CR>
" Show diagnostics
nnoremap <Leader>sd <cmd>Telescope lsp_workspace_diagnostics<CR>

" Telly colors not really working for me
highlight TelescopeSelection guifg=#FF38A2 gui=bold
highlight TelescopeMatching guifg=#d9bcef

"----------------------------

" Previous file
nnoremap <Leader>pf <C-^>
" Tabbing autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"terminal remap
tnoremap <Esc> <C-\><C-n>

imap <silent> <c-p> <Plug>(completion_trigger)
