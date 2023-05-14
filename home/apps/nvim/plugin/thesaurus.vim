" ===========================================================================
" ============================== Thesaurus ==================================
" ===========================================================================

" Disable default keymap
let g:tq_map_keys = 0
" Enable other language backends
" let g:tq_language=['en', 'de', 'fr']
" Set backends to use, using only offline ones
let g:tq_enabled_backends=['openoffice_en', 'mthesaur_txt']
" let g:tq_enabled_backends=['openoffice_en', 'datamuse_com', 'mthesaur_txt']
" Set backend timeout
let g:tq_online_backends_timeout = 0.4
" Truncate definitions lists
" let g:tq_truncation_on_definition_num = 3
" let g:tq_truncation_on_syno_list_size = 200
" Provide destination of thesaurus file
let g:tq_mthesaur_file = '~/.vim/thesaurus/mthesaur.txt'
let g:tq_openoffice_en_file = '~/.vim/thesaurus/openoffice/th_en_US_new'
