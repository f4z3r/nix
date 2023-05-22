local utils = {}

local os = require('os')

function utils.get_temp_file()
  return vim.fs.joinpath('/tmp', os.date('%Y-%m-%dT%H-%M-%S'))
end

function utils.copy_to_clipboard()
  vim.cmd('let @+=@')
  vim.notify([[System clipbord updated]])
end

return utils
