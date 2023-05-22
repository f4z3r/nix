" ===========================================================================
" =========================== Visualisation =================================
" ===========================================================================


" ==== Colors ============================================================{{{
if $STY ==# ''
  set termguicolors
endif
set t_Co=256
" }}}


" ==== Theme ============================================================={{{
if $NIX_THEME ==# 'light'
  set background=light
else
  set background=dark
endif
" set low contrast mode
let g:gruvbox_material_background = 'soft'
" set theme
colorscheme gruvbox-material
" }}}


" ==== Encodings ========================================================={{{
set encoding=UTF-8
" }}}


" ==== Column Indicators ================================================={{{
set colorcolumn=+1
highlight ColorColumn ctermbg=darkgrey
set cursorline cursorlineopt=number
highlight CursorLineNr cterm=bold ctermfg=208 gui=bold guifg=#e78a4e
" }}}


" ==== Whitespace ========================================================{{{
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list
" }}}


" ==== Indentation ======================================================={{{
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set smarttab
set expandtab
" }}}


" ==== Liner Ruler ======================================================={{{
set number
set norelativenumber
" set signs to be displayed in number column
set signcolumn=number
" }}}


" ==== Folding ==========================================================={{{
set nofoldenable
" }}}
