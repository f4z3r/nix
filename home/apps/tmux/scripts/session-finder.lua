#!/usr/bin/env luajit

local io = require("io")
local os = require("os")
local string = require("string")
local table = require("table")

local json = require("rapidjson")

local function run(cmd)
  local filename = os.tmpname()
  local command = string.format("%s > %s", cmd, filename)
  local success, _, code = os.execute(command)
  local fh = assert(io.open(filename, "r"))
  local out = fh:read("*a")
  fh:close()
  os.remove(filename)
  if not success then
    return code, out
  end
  return 0, out:gsub("\n$", "")
end

local function get_repo_paths()
  local cmd = "gfold ~/opt -c never -d json"
  local code, out = run(cmd)
  if code ~= 0 then
    os.exit(code)
  end
  local repos = json.decode(out)
  local res = { "/home/f4z3r/notes " }
  for _, repo in ipairs(repos) do
    res[#res + 1] = string.format("%s/%s", repo.parent, repo.name)
  end
  return res
end

local function pick(options)
  local content = table.concat(options, "\n")
  local cmd = string.format('echo -ne "%s" | rofi -dmenu -p "Repository" -i -no-custom', content)
  local code, out = run(cmd)
  if code ~= 0 then
    os.exit(code)
  end
  return out
end

local function escape_dir_name(name)
  return name:gsub("/", "_"):gsub("%.", "_")
end

local function tmux_session_exists(name)
  return os.execute(string.format("tmux has-session -t=%s 2> /dev/null", name)) == 0
end

local function create_tmux_session(path, name)
  os.execute(string.format("tmux new-session -ds %s -c %s", name, path))
end

local function switch_to_tmux_session(name)
  os.execute(string.format("tmux switch-client -t %s", name))
end

local function main()
  local repos = get_repo_paths()
  local selected = pick(repos)
  if not selected or selected == "" then
    os.exit(1)
  end
  local session_name = escape_dir_name(selected)
  local exists = tmux_session_exists(session_name)
  if not exists then
    create_tmux_session(selected, session_name)
  end
  switch_to_tmux_session(session_name)
end

main()
