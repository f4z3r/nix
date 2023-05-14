" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" ==== Visualisation ====================================================={{{
setlocal textwidth=120

" Use tabs instead of spaces for go
setlocal autoindent
setlocal smartindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal smarttab
setlocal noexpandtab

" Show indent lines even though using tab
setlocal listchars=tab:\|\ 
setlocal list
" }}}


" ==== Bindings =========================================================={{{
" (d)ebug toggle a (b)reakpoint
nnoremap <buffer> <localleader>db :DlvToggleBreakpoint<cr>
" (d)ebug toggle a (t)racepoint
nnoremap <buffer> <localleader>dt :DlvToggleTracepoint<cr>
" (t)est (d)ebug
nnoremap <buffer> <localleader>td :DlvTestCurrent<cr>
" (d)ebug test (a)ll
nnoremap <buffer> <localleader>da :DlvTest<cr>
" (d)ebug (c)lear all points
nnoremap <buffer> <localleader>dc :DlvClearAll<cr>
" }}}
