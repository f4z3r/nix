" ===========================================================================
" ================================ Misc =====================================
" ===========================================================================


" ==== Bracket Matching =================================================={{{
set showmatch
set matchtime=0
" }}}


" ==== Splits ============================================================{{{
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
" }}}


" ==== Status Line ======================================================={{{
set laststatus=2
" }}}


" ==== Wrapping =========================================================={{{
set nowrap
set formatoptions+=q
" }}}


" ==== Persistency ======================================================={{{
set history=1000
set undofile
" }}}


" ==== Sessions =========================================================={{{
if ! isdirectory(expand('~/.vim/sessions/'))
  call mkdir(expand('~/.vim/sessions/'), 'p')
endif
set sessionoptions-=options    " do not store global and local values in a session
set sessionoptions-=folds      " do not store folds
" }}}


" ==== Wild Menu ========================================================={{{
set wildmenu
set wildmode=list:longest,full
" }}}


" ==== Hidden Files ======================================================{{{
set hidden                   " use hidden files for unsaved buffer switches
set autoread                 " read changed files into buffers if needed
" }}}


" ==== Tags =============================================================={{{
set noautochdir
set tags=tags;/              " check every directory up for tags
" }}}


" ==== Vimrc Editing ====================================================={{{
augroup boot_vimrc
  autocmd bufwritepost *.vimrc source $MYVIMRC
augroup END
" }}}

set secure
