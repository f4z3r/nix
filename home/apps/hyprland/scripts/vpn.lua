#!/usr/bin/env luajit

local os = require("os")
local string = require("string")

local COUNRTY_CODES = {
  "ch",
  "uk",
  "de",
}

local function is_active(cc)
  local cmd = string.format("/run/current-system/sw/bin/systemctl is-active openvpn-%s.service > /dev/null", cc)
  return os.execute(cmd) == 0
end

local function is_failed(cc)
  local cmd = string.format("/run/current-system/sw/bin/systemctl is-failed openvpn-%s.service > /dev/null", cc)
  return os.execute(cmd) == 0
end

local function main()
  for _, cc in ipairs(COUNRTY_CODES) do
    if is_active(cc) then
      local output = string.upper(cc)
      if is_failed(cc) then
        output = string.format("%%{F#CC241D}%s%%F{F-}", output)
      end
      print(output)
      return
    end
  end
  os.exit(1)
end

main()
