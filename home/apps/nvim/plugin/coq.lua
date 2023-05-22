vim.g.coq_settings = { auto_start = 'shut-up', xdg = true }
vim.g.coq_settings.keymap = {
  recommended = false,
  -- TODO
  jump_to_mark = '',
  manual_complete = '<c-space',
  manual_complete_insertion_only = true,
}
vim.g.coq_settings.completion = {
  skip_after = { '{', '}', '[', ']', ')', ' ' },
}

vim.keymap.set('i', '<tab>', function()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info().selected == -1 then
      return '<c-n><c-y>'
    else
      return '<c-y>'
    end
  else
    return '<tab>'
  end
end, { expr = true, silent = true })
