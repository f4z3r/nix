local utils = {}

local io = require("io")
local os = require("os")
local string = require("string")

function utils.run(cmd)
  local ph = assert(io.popen(cmd, "r"))
  local res = {}
  for line in ph:lines() do
    res[#res + 1] = line
  end
  ph:close()
  return res
end

function utils.get_temp_file()
  return string.format("/tmp/neovim_%s", os.date("%Y-%m-%dT%H-%M-%S"))
end

function utils.copy_to_clipboard()
  vim.cmd("let @+=@")
  vim.notify("Copied data to system clipboard", vim.log.levels.INFO, {
    title = "Clipboard",
    timeout = 500,
  })
end

return utils
