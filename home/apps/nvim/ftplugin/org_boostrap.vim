" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" ==== Tabbing ==========================================================={{{
setlocal textwidth=120
setlocal foldlevel=2
setlocal shiftwidth=1
setlocal tabstop=1
" }}}


" ==== Conceal ==========================================================={{{
setlocal conceallevel=2
setlocal concealcursor=n
" }}}


" ==== Bindings =========================================================={{{
" conceal (e)nable
nnoremap <buffer> <localleader>e :set conceallevel=2<cr>
" conceal (d)isable
nnoremap <buffer> <localleader>d :set conceallevel=0<cr>
" }}}


" ==== Abbreviations ====================================================={{{
inoreabbrev todo TODO
inoreabbrev <silent><buffer> bsrc #+BEGIN_SRC
inoreabbrev <silent><buffer> esrc #+END_SRC<cr><bs>
inoreabbrev <silent><buffer> bqu #+BEGIN_QUOTE<cr><bs>
inoreabbrev <silent><buffer> equ #+END_QUOTE<cr><bs>
inoreabbrev <silent><buffer> :p: :PROPERTIES:<cr><bs>
inoreabbrev <silent><buffer> :e: :END:<cr><bs>
" }}}


" ==== Spelling ==========================================================={{{
augroup OrgFileEnableSpelling
  autocmd!
  autocmd BufRead,BufEnter *.org set spell
augroup END
" }}}
