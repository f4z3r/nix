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
    timeout = 1000,
  })
end

function utils.open_with_broot()
  assert(
    os.execute(
      [[tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E 'tmux new-session -s nvim-broot "broot > /tmp/broot-capture"']]
    )
  )
  local fh_reader, err = io.open("/tmp/broot-capture", "r")
  if err then
    return
  end
  fh_reader = assert(fh_reader, "could not read broot capture")
  local content = fh_reader:read("*a")
  fh_reader:close()
  if content == "" then
    return
  end
  vim.cmd(string.format("e %s", content))
end

return utils
