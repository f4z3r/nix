" ===========================================================================
" ===================== Language Specific Settings ==========================
" ===========================================================================

" ==== Bindings =========================================================={{{
" (t)able of contents (g)enerate
nnoremap <buffer> <localleader>g :InsertToc<cr>
" (t)able of contents (s)how
nnoremap <buffer> <localleader>s :Toc<cr>
" (f)ormat table
vnoremap <buffer> <localleader>f :EasyAlign*<bar><cr>
nnoremap <buffer> <localleader>f vip:EasyAlign*<bar><cr>
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


" ==== Obsidian =========================================================={{{
augroup ObsidianPath
  autocmd!
  autocmd BufNewFile,BufRead,VimEnter /home/jakob/data/obsidian/* lcd! /home/jakob/data/obsidian/
  autocmd BufNewFile,BufRead,VimEnter /home/jakob/data/obsidian/* setlocal path+=/home/jakob/data/obsidian/** suffixesadd+=.md
augroup END
" }}}
