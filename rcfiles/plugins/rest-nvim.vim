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
endfunction
nmap rr     :call DoRest()<CR>
