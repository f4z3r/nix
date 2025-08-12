local io = require("io")
local os = require("os")
local string = require("string")

local BUFFER_SIZE = 2 ^ 13 -- good buffer size (8K)
local CLIPBOARD_STATE = "CLIPBOARD_STATE"
local STATE_SENSITIVE = "sensitive"

local function run(cmd)
  local pid = assert(io.popen(cmd))
  local out = pid:read("*a")
  pid:close()
  return out
end

local function sensitive()
  local out = run("wl-paste --list-types")
  local secret = string.find(out, "text/sensitive", nil, true) ~= nil
  local internal_source = string.find(out, "chromium/x-internal-source-rfh-token", nil, true) ~= nil
  local web_source = string.find(out, "chromium/x-web-custom-data", nil, true) ~= nil
  local proton_pass = internal_source and not web_source
  return secret or proton_pass
end

local function main()
  local state = os.getenv(CLIPBOARD_STATE)
  if state == STATE_SENSITIVE or sensitive() then
    return
  end

  local fp = assert(io.popen("cliphist -max-dedupe-search 10 -max-items 500 store", "w"))
  while true do
    local blob = io.read(BUFFER_SIZE)
    if not blob then
      break
    end
    fp:write(blob)
  end
  fp:close()
end

main()
