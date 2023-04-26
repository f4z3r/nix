 scriptencoding utf-8
" ===========================================================================
" ================================ Airline ==================================
" ===========================================================================


if !exists('g:airline_symbols')
  let g:airline_symbols= {}
endif
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ' [none]'
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
  return '[' . a:name . '] '
endfunction

let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 1

let g:airline#extensions#ale#error_symbol = ''
let g:airline#extensions#ale#warning_symbol = ''
let airline#extensions#ale#show_line_numbers = 0

let g:airline#extensions#coc#error_symbol = ''
let g:airline#extensions#coc#warning_symbol = ''

let g:airline_theme= 'gruvbox_material'
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.space = ' '
let g:airline_symbols.spell = '暈'
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : '',
      \ 'i'      : '奈',
      \ 'ic'     : '奈',
      \ 'ix'     : '奈',
      \ 'n'      : '',
      \ 'multi'  : 'ﯟ',
      \ 'ni'     : '',
      \ 'no'     : '',
      \ 'R'      : 'זּ',
      \ 'Rv'     : 'זּ',
      \ 's'      : '',
      \ 'S'      : '',
      \ ''     : '',
      \ 't'      : '',
      \ 'v'      : '麗',
      \ 'V'      : '麗',
      \ ''     : '麗',
      \ }


let spc = g:airline_symbols.space
let arr = g:airline_right_alt_sep

let g:airline#extensions#term#enabled = 0

let g:airline#extensions#wordcount#formatter = 'kilo'
let g:airline#extensions#wordcount#formatter#kilo#fmt = "%s\uf72c"
let g:airline#extensions#wordcount#formatter#kilo#fmt_short = '%s'

let g:airline_extensions = ['ale', 'branch', 'coc', 'fern',
      \'fugitiveline', 'hunks', 'keymap', 'netrw', 'po', 'tagbar',
      \'quickfix','tabline', 'vimtex', 'wordcount', 'gutentags']
