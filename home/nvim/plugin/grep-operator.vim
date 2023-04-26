" ===========================================================================
" ============================= Grep Operator ===============================
" ===========================================================================

if exists('g:custom_grep_operator_loaded')
  finish
endif

nnoremap ss :set operatorfunc=GrepOperator<cr>g@
vnoremap ss :<c-u>call GrepOperator(visualmode())<cr>

let g:custom_grep_operator_loaded = 1
