"let g:javascript_plugin_jsdoc = 1

"--- LIT highlighting and autclosing
let g:htl_css_templates = 1
let g:htl_all_templates = 1
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
      \ 'javascript.jsx': 'jsxRegion,litHtmlRegion',
      \ 'javascript':     'litHtmlRegion',
      \ 'typescript':     'litHtmlRegion',
      \ }

