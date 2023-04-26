" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" Disable rainbow parentheses for text files by default
augroup TextFileRainbowUndoGroup
  autocmd!
  autocmd BufRead,BufEnter *.txt RainbowToggleOff
augroup END

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
