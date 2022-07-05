require 'rcfiles.plugins'
require 'rcfiles.plugins.compe'
require 'rcfiles.plugins.lspconfig-settings'
require 'rcfiles.plugins.rest-nvim-settings'
require 'rcfiles.plugins.telescope-settings'
require 'rcfiles.plugins.treesitter-settings'
require 'rcfiles.plugins.nvim_dap-settings'

require 'rcfiles.statusline'
require 'rcfiles.tabline'.Setup()
require 'rcfiles.opts'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
" TODO: VimScript to Lua
    hi LinrNr term=NONE
    filetype plugin indent on

    colorscheme pinkmare

    hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#87c095 guifg=NONE

    " -- Dev icons for nerdtree
    set encoding=UTF-8
    " -- Open nerdtree on leader t
    nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
    let NERDTreeShowHidden=1

    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1

    let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
    let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

    let g:AutoPairsShortcutToggle = ''
    let g:AutoPairsShortcutBackInsert = '<M-0>'


    "  ______                         _   _   _             
    " |  ____|                       | | | | (_)            
    " | |__ ___  _ __ _ __ ___   __ _| |_| |_ _ _ __   __ _ 
    " |  __/ _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
    " | | | (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
    " |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
    "                                                  __/ |
    "                                                 |___/
    let useformatting=1
    function DoFormat() 
        if has("nvim") && g:useformatting
            lua vim.lsp.buf.formatting_sync(nil, 1000)
        endif
    endfunction

    if useformatting
        "autocmd BufWritePre *.java  call DoFormat()
        autocmd BufWritePre *.md call DoFormat()
        autocmd BufWritePre *.js call DoFormat()
        autocmd BufWritePre *.ts call DoFormat()
        autocmd BufWritePre *.clj call DoFormat()
        autocmd BufWritePre *.html Neoformat
    endif


    command! ToggleFormatting let useformatting = (useformatting == 0 ? 1 : 0) 

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
    nnoremap <Leader>ee    <cmd>lua vim.diagnostic.show_line_diagnostics()<CR>
    "Show error
    nnoremap <Leader>se    <cmd>lua vim.diagnostic.goto_next { wrap = true }<CR>

    nnoremap <Leader>bn :bn<CR>
    nnoremap <Leader>bp :bp<CR>
    nnoremap <Leader>bl :bn<CR>
    nnoremap <Leader>bh :bp<CR>


    nnoremap <Leader>+ :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>

    " Undo break points
    inoremap , ,<c-g>u
    inoremap . .<c-g>u
    inoremap ! !<c-g>u
    inoremap ? ?<c-g>u
    inoremap : :<c-g>u
    inoremap ; ;<c-g>u
    inoremap ; ;<c-g>u

    " Jumplist mutations
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

    " Previous file
    nnoremap <Leader>pf <C-^>

    imap <silent> <c-p> <Plug>(completion_trigger)

    " Markdown preview
    nmap <Leader>mp <Plug>MarkdownPreview
    let g:mkdp_markdown_css = expand('~/dotfiles/markdown.css')
    " commentary
    noremap <Leader>cc :Commentary<CR>
    noremap <Leader>cs {v}:Commentary<CR>
    " Maximizer
    nnoremap <Leader>fs :MaximizerToggle<CR>
    " Nerdtree
    nnoremap <Leader>ntf :NERDTreeFind<CR>
]])
