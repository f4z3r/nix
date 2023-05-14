" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" ==== Bindings =========================================================={{{
" conceal (e)nable
nnoremap <buffer> <localleader>e :set conceallevel=2<cr>
" conceal (d)isable
nnoremap <buffer> <localleader>d :set conceallevel=0<cr>
" }}}


" ==== Conceal ==========================================================={{{
setlocal conceallevel=2
setlocal concealcursor=n
" }}}


" ==== Wrapping =========================================================={{{
setlocal textwidth=100
setlocal formatoptions=nqjtc
setlocal nojoinspaces
" }}}


" ==== Spelling =========================================================={{{
setlocal spell
" }}}
