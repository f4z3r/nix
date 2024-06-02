#!/usr/bin/env luajit

local io = require("io")
local json = require("rapidjson")
local string = require("string")
local table = require("table")

local function run(cmd)
  local ph = assert(io.popen(cmd, "r"))
  local out = ph:read("*a")
  ph:close()
  return out:gsub("\n$", "")
end

local function get_repo_paths()
  local cmd = "gfold ~/opt -c never -d json"
  local out = run(cmd)
  local repos = json.decode(out)
  local res = { '/home/f4z3r/notes '}
  for _, repo in ipairs(repos) do
    res[#res + 1] = string.format("%s/%s", repo.parent, repo.name)
  end
  return res
end

local function pick(options)
  local content = table.concat(options, "\n")
  local cmd = string.format('echo -ne "%s" | rofi -dmenu -p "Repository" -i -no-custom', content)
  return run(cmd)
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
  local session_name = escape_dir_name(selected)
  local exists = tmux_session_exists(session_name)
  if not exists then
    create_tmux_session(selected, session_name)
  end
  switch_to_tmux_session(session_name)
end

main()
