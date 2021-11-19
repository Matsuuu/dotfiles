function! TabLine()
      let s = ''
      for i in range(tabpagenr('$'))
            let tabnr = i + 1 " range() starts at 0
            let winnr = tabpagewinnr(tabnr)
            let buflist = tabpagebuflist(tabnr)
            let bufnr = buflist[winnr - 1]
            let bufname = fnamemodify(bufname(bufnr), ':t')

            let s .= '%#TabLineFill# | '
            let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

            let n = '' 
            if n > 1 | let s .= ':' . n | endif

            let s .= empty(bufname) ? ' [No Name] ' : WebDevIconsGetFileTypeSymbol(bufname) . ' ' . bufname . ' '

            let bufmodified = getbufvar(bufnr, "&mod")
            if bufmodified | let s .= '+ ' | endif
      endfor
      let s .= '%#TabLineFill#'
      return s
endfunction

set tabline=%!TabLine()
