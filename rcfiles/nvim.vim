" This file contains all of the nvim specific stuff

"--- Nvim lsp settings
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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

source ~/.vim/rcfiles/lua/compe.vim
source ~/.vim/rcfiles/lua/lsp_status.vim
source ~/.vim/rcfiles/lua/lspconfig.vim
source ~/.vim/rcfiles/lua/rest-nvim.vim
source ~/.vim/rcfiles/lua/telescope.vim
source ~/.vim/rcfiles/lua/treesitter.vim

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
" God damn tmux taking the C-B bind
nnoremap <C-L> <cmd>Telescope buffers<CR>
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

" neovim rest
function! DoRest() 
    lua require "rest-nvim".run()
    redraw
    sleep 100m
    vertical resize 50
endfunction
"nmap <leader>rr     <cmd> lua require "rest-nvim".run()<CR>:vertical resize 50<CR>
nmap <leader>rr     :call DoRest()<CR>
