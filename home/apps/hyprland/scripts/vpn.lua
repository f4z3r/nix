#!/usr/bin/env luajit

local io = require("io")
local os = require("os")
local string = require("string")

local json = require("rapidjson")
local request = require("http.request")

local TIMEOUT = 2

local COUNRTY_CODES = {
  "ch",
  "uk",
  "de",
}

local PROTON_SERVERS = {
  "datacamp limited",
  "proton ag",
}

local function is_active(cc)
  local cmd = string.format("/run/current-system/sw/bin/systemctl is-active openvpn-%s.service > /dev/null", cc)
  return os.execute(cmd) == 0
end

local function is_failed(cc)
  local cmd = string.format("/run/current-system/sw/bin/systemctl is-failed openvpn-%s.service > /dev/null", cc)
  return os.execute(cmd) == 0
end

local function is_proton_isp(isp)
  local base = string.lower(isp)
  for _, v in ipairs(PROTON_SERVERS) do
    if string.find(base, v, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local function using_proton_isp()
  local nok, stream = request.new_from_uri("http://ip-api.com/json/"):go(TIMEOUT)
  if nok == nil then
    return false
  end
  local body = stream:get_body_as_string(TIMEOUT)
  if body == nil then
    return false
  end
  local data = json.decode(body)
  return is_proton_isp(data.isp)
end

local function main()
  for _, cc in ipairs(COUNRTY_CODES) do
    if is_active(cc) then
      local output = string.upper(cc)
      if is_failed(cc) or not using_proton_isp() then
        output = string.format('<span color="#CC241D">%s</span>', output)
      end
      print(output)
      return
    end
  end
  os.exit(1)
end

main()
