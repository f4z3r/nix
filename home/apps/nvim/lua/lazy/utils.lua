local utils = {}

local quotes = require("lazy.quotes")
local os = require('os')

function utils.get_temp_file()
  return string.format('/tmp/neovim_%s', os.date('%Y-%m-%dT%H-%M-%S'))
end

function utils.copy_to_clipboard()
  vim.cmd('let @+=@')
  vim.notify("Copied data to system clipboard", vim.log.levels.INFO, {
    title = "Clipboard",
    timeout = 1000,
  })
end

return utils
