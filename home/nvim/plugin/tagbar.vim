" ===========================================================================
" =============================== Tagbar ====================================
" ===========================================================================

" improve width on zoom (x)
let g:tagbar_zoomwidth = 0
" make compact
let g:tagbar_compact = 1
" autofocus when activated
let g:tagbar_autofocus = 1
" close when jumping to a tag
let g:tagbar_autoclose = 1


" Julia support
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : [
        \ 't:struct',
        \ 'f:function',
        \ 'a:abstract',
        \ 't:type',
        \ 'i:immutable',
        \ 'm:macro',
        \ 'c:const']
    \ }

" Nim support
let g:tagbar_type_nim = {
    \ 'ctagstype': 'nim',
    \ 'kinds' : [
        \'c:classes',
        \'e:enums',
        \'t:tuples',
        \'r:subranges',
        \'P:proctypes',
        \'f:functions',
        \'p:procedures',
        \'m:methods',
        \'o:operators',
        \'T:templates',
        \'M:macros'
    \ ]
\}

" Perl support
let g:tagbar_type_perl = {
    \ 'ctagstype' : 'perl',
    \ 'kinds'     : [
        \ 'p:package:0:0',
        \ 'w:roles:0:0',
        \ 'e:extends:0:0',
        \ 'u:uses:0:0',
        \ 'r:requires:0:0',
        \ 'o:ours:0:0',
        \ 'a:properties:0:0',
        \ 'b:aliases:0:0',
        \ 'h:helpers:0:0',
        \ 's:subroutines:0:0',
        \ 'd:POD:1:0'
    \ ]
\ }

" Rust support
" provided by rust.vim
