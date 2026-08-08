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

function utils.split(str, sep)
  sep = sep or "%s"
  local result = {}
  local from = 1
  local delim_from, delim_to = str:find(sep, from)
  while delim_from do
    table.insert(result, str:sub(from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = str:find(sep, from)
  end
  table.insert(result, str:sub(from))
  return result
end

function utils.select_with_tv(items)
  if type(items) == "string" then
    -- handle channel
    assert(
      os.execute(
        string.format(
          [[tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80%% -h 75%% -E 'tv %s > /tmp/tv-capture']],
          items
        )
      )
    )
  else
    -- handle item list, use input file to avoid quote issues with bash
    local fh_writer, err = io.open("/tmp/tv-input", "w")
    if err then
      return
    end
    fh_writer = assert(fh_writer, "could not open tv input")
    fh_writer:write(table.concat(items, "\n"))
    fh_writer:close()
    assert(
      os.execute(
        [[tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E 'cat /tmp/tv-input | tv > /tmp/tv-capture']]
      )
    )
    assert(os.execute([[rm "/tmp/tv-input"]]))
  end
  local fh_reader, err = io.open("/tmp/tv-capture", "r")
  if err then
    return
  end
  fh_reader = assert(fh_reader, "could not read tv capture")
  local content = fh_reader:read("*a")
  fh_reader:close()
  return content
end

return utils
