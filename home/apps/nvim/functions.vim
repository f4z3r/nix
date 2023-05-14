function Copy_to_clipboard()
  let @+=@"
  echom 'Vim default register (>' . @" . '<) copied to system clipbard.'
endfunction

function Get_tmp_file()
  let name = '/tmp/vim_tmp_' . localtime()
  return name
endfunction


function Get_project_root()
  return trim(system('git rev-parse --show-toplevel'))
endfunction

function Toggle_background()
  if &background ==# 'dark'
    execute 'set background=light' 
  else
    execute 'set background=dark'
  endif
  execute ':AirlineTheme gruvbox_material'
endfunction

function Toggle_wrap()
  if &wrap
    execute 'set nowrap'
  else
    execute 'set wrap'
  endif
endfunction

function! GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  silent execute 'vimgrep! |\<' . @@ . '\>| %'
  copen

  let @@ = saved_unnamed_register
endfunction


