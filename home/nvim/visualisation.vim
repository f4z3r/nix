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
if $KITTY_THEME ==# 'light'
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
set relativenumber
" toggle relative and absolute numbering based on mode
augroup LineNumberGroup
  autocmd!
  autocmd InsertEnter * :set nornu
  autocmd InsertLeave * :set rnu
augroup END
" set signs to be displayed in number column
set signcolumn=number
" }}}
