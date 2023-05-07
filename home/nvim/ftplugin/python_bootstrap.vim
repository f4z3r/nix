" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" ==== Visualisation ====================================================={{{
setlocal textwidth=100
" }}}

" ==== Testing ==========================================================={{{
" (t)est (n)earest
nnoremap <leader>tn :CocCommand pyright.singleTest<cr>
" (t)est (f)ile
nnoremap <leader>tf :CocCommand pyright.fileTest<cr>
" }}}
