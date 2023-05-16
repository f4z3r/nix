" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

setlocal textwidth=120
setlocal foldlevel=2
setlocal shiftwidth=1
setlocal tabstop=1
setlocal conceallevel=2

inoreabbrev todo TODO

inoreabbrev <silent><buffer> bsrc #+BEGIN_SRC
inoreabbrev <silent><buffer> esrc #+END_SRC<cr><bs>
inoreabbrev <silent><buffer> bqu #+BEGIN_QUOTE<cr><bs>
inoreabbrev <silent><buffer> equ #+END_QUOTE<cr><bs>

inoreabbrev <silent><buffer> :p: :PROPERTIES:<cr><bs>
inoreabbrev <silent><buffer> :e: :END:<cr><bs>

augroup OrgFileEnableSpelling
  autocmd!
  autocmd BufRead,BufEnter *.org set spell
augroup END
