" ===========================================================================
" ============================ EasyMotion ===================================
" ===========================================================================

" perform overwindow easymotion search on space after search
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {
      \     "\<space>": '<Over>(easymotion)'
      \   },
      \   'is_expr': 0
      \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
" (t)ouch {char}{char} to move to {char}{char}
nmap t <Plug>(easymotion-overwin-f2)
