vim.g.coq_settings = {
  auto_start = 'shut-up',
  xdg = true,
  ['keymap.recommended'] = false,
  ['keymap.pre_select'] = true,
  ['keymap.jump_to_mark'] = 'c-j',
  ['keymap.manual_complete'] = 'c-<space>',
  ['keymap.manual_complete_insertion_only'] = true,
  ['completion.skip_after'] = { '{', '}', '[', ']', ')', ' ' },
}

vim.keymap.set('i', '<tab>', function()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info().selected == -1 then
      return '<c-e><tab>'
    else
      return '<c-y>'
    end
  else
    return '<tab>'
  end
end, { expr = true, silent = true })

vim.keymap.set('i', '<esc>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-e><esc>'
  else
    return '<esc>'
  end
end, { expr = true, silent = true })

vim.keymap.set('i', '<cr>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-e><cr>'
  else
    return '<cr>'
  end
end, { expr = true, silent = true })
