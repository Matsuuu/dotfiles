source ~/.vim/rcfiles/coc-defaults.vim
 "--- COC
set cmdheight=2
set updatetime=50
autocmd CursorHold * silent call CocActionAsync('highlight')


"--- Extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-lit-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-xml', {'do': 'yarn install --frozen-lockfile'}
Plug 'dansomething/coc-java-debug', {'do': 'yarn install --frozen-lockfile'}

" Remap keys for applying codeAction to the current line.
nmap <leader><CR> <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent><C-b> <Plug>(coc-definition)
nmap <silent><C-h> <Plug>(coc-definition) :wincmd s<CR> :wincmd w<CR> :resize 15<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <leader>rr <Plug>(coc-rename)
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
