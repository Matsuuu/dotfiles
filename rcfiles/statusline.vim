" ------ Statusline

" Cheers https://gist.github.com/tasmo for the unicodes
let left = ''
let right = ''

set laststatus=2

set statusline=
set statusline=%9*
set statusline+=%=


silent! !git rev-parse --is-inside-work-tree
let isGitDirectory = v:shell_error == 0
"Status

set statusline+=%#StatusBalloonColor#
set statusline+=%{left}
set statusline+=%#StatusBarColor#
set statusline+=\ \ 
set statusline+=%{StatuslineMode()}
set statusline+=%m
set statusline+=\ \ 
set statusline+=%#StatusBalloonColor#

set statusline+=%{right}%9*
set statusline+=%=

"Git

if isGitDirectory
    set statusline+=%4*%{left}%7*\ \ 
    set statusline+=%{FugitiveHead()}
    set statusline+=\ %4*%{right}%9*
    set statusline+=%=
end
"Filename
set statusline+=%4*%{left}%6*\ \ 
set statusline+=%.25F
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
set statusline+=%{CheckFT(&filetype)}
set statusline+=\ \ 
set statusline+=%8*%{LspStatus()}
set statusline+=\ %1*%{right}%9*
set statusline+=%=

" Balloon
hi link User2 NormalColor
" Alt balloon
hi link User3 NormalAlt
" For rounders
hi link User4 NormalColorFG
" Alt rounders
hi link User5 NormalAltFG
hi link User6 FancyTextColor
hi link User7 FancyTextColorTwo
hi link User8 FancyTextColorThree
hi link User1 FancyTextColorThreeFG
" Clear
hi User9 guifg=white 

hi FancyTextColor guifg=#cec09a guibg=#2d2f42
hi FancyTextColorTwo guifg=#fff0f5 guibg=#2d2f42
hi FancyTextColorThree guifg=#f39305 guibg=#242021
hi FancyTextColorThreeFG guifg=#242021 
hi NormalColor guifg=#fff0f5 guibg=#2d2f42
hi NormalColorFG guifg=#2d2f42
hi NormalAlt guibg=#fe7c8e guifg=#000000
hi NormalAltFG guifg=#fe7c8e
hi VisualColor guibg=#fff0f5 guifg=#202330
hi VisualColorFG guifg=#fff0f5
hi InsertColor guibg=#ff38a2 guifg=#fff0f5
hi InsertColorFG guifg=#ff38a2
hi CommandColor guibg=#6d7a72 guifg=#fff0f5
hi CommandColorFG guifg=#6d7a72

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    hi link StatusBarColor NormalColor
    hi link StatusBalloonColor NormalColorFG
    return "NORMAL"
  elseif l:mode==?"v"
    hi link StatusBarColor VisualColor
    hi link StatusBalloonColor VisualColorFG
    return "VISUAL"
  elseif l:mode==#"i"
    hi link StatusBarColor InsertColor
    hi link StatusBalloonColor InsertColorFG
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    hi link StatusBarColor CommandColor
    hi link StatusBalloonColor CommandColorFG
    return "CMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! CheckFT(filetype)
    if a:filetype == ''
        return '-'
    else 
        let s = WebDevIconsGetFileTypeSymbol()
        let s .= " "
        let s .= tolower(a:filetype)
        return s
        "return tolower(a:filetype)
    endif
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return " " . luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction
