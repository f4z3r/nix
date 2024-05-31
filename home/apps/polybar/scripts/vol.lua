#!/usr/bin/env luajit

local io = require("io")
local os = require("os")
local string = require("string")

local CMD = "amixer sget Master 2> /dev/null"

local function run(cmd)
  local fh = io.popen(cmd, "r")
  if not fh then
    error("failed to run external command")
  end
  local output = fh:read("*a")
  fh:close()
  return output
end

local function main()
  local ok, out = pcall(run, CMD)
  if not ok then
    os.exit(1)
  end
  local volume = string.match(out, "%[(%d%d%%)%]")
  if not volume then
    volume = string.match(out, "%[(%d%%)%]")
  end
  if not volume then
    os.exit(1)
  end
  local off = string.find(out, "%[off%]")
  if off then
    print("%{F#7c6f64}VOL " .. volume .. "%{F-}")
  else
    print("%{F#d8a657}VOL%{F-} " .. volume)
  end
end
main()
