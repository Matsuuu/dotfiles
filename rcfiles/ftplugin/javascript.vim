nnoremap <Leader>rr :!node %<CR>
nnoremap <Leader>rl :exec '!node' '-e'  shellescape(getline('.'))<CR>
nnoremap <Leader>rp :exec ':r' '!node' '-e'  shellescape(getline('.'))<CR> :Commentary<CR>
