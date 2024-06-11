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
  local broot_config = vim.fn.expand("~/.config/broot/")
  local broot_tmp_config = "/tmp/broot"
  assert(os.execute(string.format("rm -rf %s", broot_tmp_config)))
  assert(os.execute(string.format("mkdir %s", broot_tmp_config)))
  assert(os.execute(string.format("cp %s/conf.toml %s/conf.toml", broot_config, broot_tmp_config)))
  assert(os.execute(string.format("cp -r %s/skins %s/skins", broot_config, broot_tmp_config)))
  assert(os.execute(string.format("cp %s/verbs.hjson %s/verbs.hjson", broot_config, broot_tmp_config)))
  assert(os.execute(string.format("chmod 600 %s/conf.toml", broot_tmp_config)))
  local fh = assert(io.open(string.format("%s/conf.toml", broot_tmp_config), "a+"))
  fh:write([=[

[[verbs]]
apply_to = "file"
external = "echo -n '+{line} {file}' > /tmp/broot/capture"
from_shell = true
key = "enter"
]=])
  fh:close()
  assert(
    os.execute(
      [[tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E 'tmux new-session -s nvim-broot zsh -ic "br --conf /tmp/broot/conf.toml"']]
    )
  )
  local fh_reader, err = io.open("/tmp/broot/capture", "r")
  if err then
    return
  end
  fh_reader = assert(fh_reader, "could not read broot capture")
  local content = fh_reader:read("*a")
  fh_reader:close()
  vim.cmd(string.format("e %s", content))
end

return utils
