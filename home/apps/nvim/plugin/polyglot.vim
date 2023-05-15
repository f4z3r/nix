" ===========================================================================
" =============================== Polyglot ==================================
" ===========================================================================


let g:python_highlight_all = 1

let g:vim_markdown_new_list_item_indent = 2
" shrink toc is possible
let g:vim_markdown_toc_autofit = 1
" allow folding of markdown titles
let g:markdown_folding = 1

" OrgMode setup
let g:polyglot_disabled = [ 'org' ]
au BufNewFile,BufRead *.org setfiletype org
