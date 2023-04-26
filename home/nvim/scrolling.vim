" ===========================================================================
" ============================= Scrolling ===================================
" ===========================================================================


" ==== Scroll Offsets ===================================================={{{
set scrolloff=8
set sidescrolloff=5
" }}}


" ==== Allow Folding ====================================================={{{
set foldcolumn=1
set foldenable
set foldlevel=8
set foldlevelstart=8
set foldmethod=indent
" open/close folds automatically when moving in/out
set foldopen=all
set foldclose=all
" do not show folded line count on folded line
set foldtext=getline(v:foldstart)
" }}}
