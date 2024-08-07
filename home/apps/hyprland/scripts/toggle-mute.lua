local io = require("io")
local os = require("os")
local string = require("string")

local function run(cmd)
  local pid = assert(io.popen(cmd))
  local out = pid:read("*a")
  pid:close()
  return out
end

local function muted()
  local out = run("amixer get Capture")
  local m = string.find(out, "[off]", nil, true)
  return m ~= nil
end

local function main()
  os.execute("amixer -q set Capture toggle")
  local brightness = 0
  if muted() then
    brightness = 1
  end
  local cmd = "brightnessctl -c 'leds' -d 'platform::micmute' s " .. brightness
  run(cmd)
end

main()
