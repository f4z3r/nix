
-- if !exists('g:airline_symbols')
--   let g:airline_symbols= {}
-- endif
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#branch#empty_message"] = ' [none]'
-- vim.g["airline#extensions#branch#format"] = 'CustomBranchName'
-- function! CustomBranchName(name)
--   return '[' . a:name . '] '
-- endfunction

vim.g["airline#extensions#whitespace#enabled"] = 0

vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#buffers_label"] = 'b'
vim.g["airline#extensions#tabline#tabs_label"] = 't'
vim.g["airline#extensions#tabline#fnamemod"] = ':t'
vim.g["airline#extensions#tabline#left_sep"] = ''
vim.g["airline#extensions#tabline#left_alt_sep"] = ''
vim.g["airline#extensions#tabline#right_sep"] = ''
vim.g["airline#extensions#tabline#right_alt_sep"] = ''
vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
vim.g["airline#extensions#tabline#show_close_button"] = 0
vim.g["airline#extensions#tabline#show_splits"] = 1
vim.g["airline#extensions#tabline#tab_nr_type"] = 1

vim.g["airline#extensions#ale#error_symbol"] = ''
vim.g["airline#extensions#ale#warning_symbol"] = ''
vim.a["rline#extensions#ale#show_line_numbers"] = 0

vim.g["airline#extensions#coc#error_symbol"] = ''
vim.g["airline#extensions#coc#warning_symbol"] = ''

vim.g["airline_theme"] = 'gruvbox_material'
vim.g["airline_left_alt_sep"] = ''
vim.g["airline_right_alt_sep"] = ''
vim.g["airline_left_sep"] = ''
vim.g["airline_right_sep"] = ''
vim.g["airline_symbols.crypt"] = '🔒'
vim.g["airline_symbols.linenr"] = ' '
vim.g["airline_symbols.maxlinenr"] = '☰ '
vim.g["airline_symbols.branch"] = ''
vim.g["airline_symbols.dirty"] = ''
vim.g["airline_symbols.readonly"] = ''
vim.g["airline_symbols.paste"] = ''
vim.g["airline_symbols.space"] = ' '
vim.g["airline_symbols.spell"] = '暈'
vim.g["airline_symbols.notexists"] = ''
vim.g["airline_symbols.whitespace"] = 'Ξ'
vim.g["airline_skip_empty_sections"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline_section_c"] = '%t'
vim.g["airline_mode_map"] = {
  ['__']     = '-',
  ['c']      = '',
  ['i']      = '',
  ['ic']     = '',
  ['ix']     = '',
  ['n']      = '',
  ['multi']  = 'ﯟ',
  ['ni']     = '',
  ['no']     = '',
  ['R']      = 'זּ',
  ['Rv']     = 'זּ',
  ['s']      = '',
  ['S']      = '',
  ['']     = '',
  ['t']      = '',
  ['v']      = '麗',
  ['V']      = '麗',
  ['']     = '麗',
}


-- let spc = g:airline_symbols.space
-- let arr = g:airline_right_alt_sep

vim.g["airline#extensions#term#enabled"] = 0

vim.g["airline#extensions#wordcount#formatter"] = 'kilo'
vim.g["airline#extensions#wordcount#formatter#kilo#fmt"] = "%s\uf72c"
vim.g["airline#extensions#wordcount#formatter#kilo#fmt_short"] = '%s'

vim.g["airline_extensions"] = {
  'ale', 'branch', 'coc', 'fern', 'fugitiveline', 'hunks', 'keymap', 'netrw', 'po', 'tagbar',
  'quickfix','tabline', 'vimtex', 'wordcount', 'gutentags'}
