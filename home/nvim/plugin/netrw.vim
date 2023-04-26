" ===========================================================================
" ============================== Netrw ======================================
" ===========================================================================

" Treeview is problematic when creating files and directories, as some
" directories will be handles as files.
let g:netrw_liststyle=3
" Use special syntax highlighting.
let g:netrw_special_syntax=1
" Use human readable sizes with uppercase letters.
let g:netrw_sizestyle='H'
" Show all files (normal and hidden)
let g:netrw_hide=0
" Suppress banner
let g:netrw_banner=0
" Use custom date format
let g:netrw_timefmt='%Y-%m-%d'
" sort by extension
let g:netrw_sort_by='exten'
