-- File bindings

local leader = "<leader>f"

local mappings = {
  {
    mode = 'n',
    suffix = 'a',
    command = '<cmd>A<cr>',
    desc = 'Switch to alternative file'
  },
  {
    mode = 'n',
    suffix = 'dd',
    command = '<cmd>Dispatch<cr>',
    desc = 'Synchronously dispatch on file'
  },
  {
    mode = 'n',
    suffix = 'da',
    command = '<cmd>Dispatch!<cr>',
    desc = 'Asynchronously dispatch on file'
  },
  {
    mode = 'n',
    suffix = 's',
    command = '<cmd>update<cr>',
    desc = 'Save file'
  },
  {
    mode = 'n',
    suffix = 'f',
    command = function() require('telescope.builtin').git_files() end,
    desc = 'Open git tracked file'
  },
  {
    mode = 'n',
    suffix = 'c',
    command = function() require('telescope.builtin').live_grep() end,
    desc = 'Open file with content'
  },
  {
    mode = 'n',
    suffix = 'r',
    command = '<cmd>checktime %<cr>',
    desc = 'Refresh file'
  },
 {
   mode = 'n',
   suffix = 't',
   command = function() vim.cmd(string.format('e %s', require('lazy.utils').get_temp_file())) end,
   desc = 'Open temp file'
 },
}


vim.keymap.set('n', '<c-p>', function() require('telescope.builtin').find_files() end, {
  desc = 'Open file in workspace',
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
