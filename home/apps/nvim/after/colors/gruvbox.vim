
" Custom highlight for targeted person
" Parenthesis required to not include variables such as Exilir's macros.
syntax match TargetPerson display
      \ /(@\w\+/hs=s+1
      \ contained contains=NONE
highlight TargetPerson ctermfg=red guifg=red

" Custom highlight for todos
" Dot required to have precedence over keyword TODOs.
syntax match MyTodo display
      \ /.\<\(FIXME\|TODO\|OPTIMIZE\|NOTE\|XXX\)\((@\w\+)\)\?:\?/hs=s+1
      \ contains=TargetPerson containedin=.*Comment,.*CommentTitle contained
highlight link MyTodo Todo
highlight Todo ctermfg=green guifg=green
