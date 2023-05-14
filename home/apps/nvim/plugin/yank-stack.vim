" ===========================================================================
" =============================== Yank Stack ================================
" ===========================================================================


let g:yankstack_map_keys = 0
nmap <localleader>p <Plug>yankstack_substitute_older_paste
nmap <localleader>P <Plug>yankstack_substitute_newer_paste

