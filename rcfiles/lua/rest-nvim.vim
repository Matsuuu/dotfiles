lua << END
require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      -- Jump to request line on run
      jump_to_request = false,
    })
END

" neovim rest
function! DoRest() 
    lua require "rest-nvim".run()
    redraw
    sleep 100m
    vertical resize 50
endfunction
"nmap <leader>rr     <cmd> lua require "rest-nvim".run()<CR>:vertical resize 50<CR>
nmap <leader>rr     :call DoRest()<CR>
