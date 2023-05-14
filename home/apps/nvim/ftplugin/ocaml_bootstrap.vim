" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

setlocal textwidth=100

" ==== Bindings =========================================================={{{
" (s)witch to from implementation to header and vice-versa
nnoremap <buffer> <LocalLeader>s :<c-u>call OCaml_switch(0)<cr>
" }}}
