#!/usr/bin/env luajit

local string = require("string")

local ECHO_SUBCOMMAND = "echo"
local RUN_SUBCOMMAND = "run"

local function main()
  local subcommand = arg[1]
  assert(subcommand == ECHO_SUBCOMMAND or subcommand == RUN_SUBCOMMAND, "subcommand not supported: " .. subcommand)
  local content = arg[2]:match(".-:.-:%s*(.+)")
  local test_name = content:match('%((%b"")')
  local cmd = string.format("busted --filter %s .", test_name)
  print(cmd)
  if subcommand == RUN_SUBCOMMAND then
    os.execute(cmd)
  end
end

main()
