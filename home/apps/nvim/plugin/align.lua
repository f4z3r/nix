vim.keymap.set('x', 'aa', function() require 'align'.align_to_char(1, true) end, {
  silent = true,
  desc = "Align to 1 character",
})
vim.keymap.set('x', 'as', function() require 'align'.align_to_string(false, true, true) end, {
  silent = true,
  desc = "Align to a string",
})

-- Example gawip to align a paragraph to a string, looking left and with previews
vim.keymap.set(
  'n',
  'gaw',
  function()
    local a = require 'align'
    a.operator(
      a.align_to_string,
      { is_pattern = false, reverse = true, preview = true }
    )
  end,
  {
    silent = true,
    desc = "Align to a string",
  }
)

-- Example gaaip to aling a paragraph to 1 character, looking left
vim.keymap.set(
  'n',
  'gaa',
  function()
    local a = require 'align'
    a.operator(
      a.align_to_char,
      { length = 1, reverse = true }
    )
  end,
  {
    silent = true,
    desc = "Align to 1 character",
  }
)
