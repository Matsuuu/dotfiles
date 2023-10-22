-- Be like REPL my friend
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%#//(#%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&%%##%%%%/...,*(#(%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&%%#/,,....      ....,#%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&%#(/**,..      ../(((/*//,#%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&%%#((///*,,,...,*///*.....,.,(%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&%%%%%%%%%%%%#(*****/(####/*...(%%#(%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&%%%%#(//(#####/    .......    ,##..%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&%%%%%%%(//*,,,,.             ..(( *%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&%#####(/*,...,,.     ,..     ..**#%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&%##(**,,...*/*..      .,.  ....(#%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&%###(/**/(#(#####(,..        .*%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&%#%%%%%%%###((((((*. ...,.       .,#%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&%%###(((((((###(.  /(,. .....##%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&%####((((/**/*,..      ....,#%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&%%%#####(*/(((##(*.    .,..#%%%%&%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&%%&%##%%####((*,.        .,...((#%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&%%&&&%&&&&&####%%%%#((/,... ..,*,..../#((/(#%%&&&&&&&&&&&#%%%%%%%#&&&&&
-- &&&&&&%&&&&&&&&&&&&&%#####%%%%%%%%%#(##**,...,(#####((######%&&&&&(%%%###%%&&&&&
-- &###%%&&&&&&&&&&&&&&&%######%%%%%%%%%///*,..,,(#%%####(##########%%&&&&&&&&&&&&&
-- %%%%%%%&&&&&&&&&&&&&&&%########%%%%%%#(*,,..,*#(%%%%#########%##%%%######%%%%&&&
--
-- Run current file
-- nnoremap <Leader>rr :!node %<CR>
vim.keymap.set('n', '<Leader>rf', ':!node %<CR>')
-- Run current line
--  nnoremap <Leader>rl :exec '!node' '-e'  shellescape(getline('.'))<CR>
-- Run current line, print it below it, and comment it
-- nnoremap <Leader>rp :exec ':r' '!node' '-e'  shellescape(getline('.'))<CR> :Commentary<CR>
local inspect = require("rcfiles.lua-convenience.inspect")

local run_selection = function()
  local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)

  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end


  local code = table.concat(lines, ' ')

  vim.cmd("!node -e 'console.log(`\\n`); " .. code .. "'")
end

vim.keymap.set('v', '<Leader>rs', run_selection)


-- TODO: Do I need these anymore?
vim.g.javascript_plugin_jsdoc = 1
----- LIT highlighting and autclosing
vim.g.htl_css_templates = 1
vim.g.htl_all_templates = 1
vim.g.closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
--vim.g.closetag_regions = {
--      'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
--      'javascript.jsx': 'jsxRegion,litHtmlRegion',
--      'javascript':     'litHtmlRegion',
--      'typescript':     'litHtmlRegion',
--      }

