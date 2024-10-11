#!/usr/bin/env luajit

local io = require("io")
local os = require("os")
local string = require("string")

local secret_patterns = {
  "pass.*=",
  "token.*=",
  "secret.*=",
}

local key_file_headers = {
  "BEGIN RSA PRIVATE KEY",
  "BEGIN DSA PRIVATE KEY",
  "BEGIN EC PRIVATE KEY",
  "BEGIN OPENSSH PRIVATE KEY",
  "BEGIN PRIVATE KEY",
  "BEGIN SSH2 ENCRYPTED PRIVATE KEY",
  "BEGIN PGP PRIVATE KEY BLOCK",
  "BEGIN ENCRYPTED PRIVATE KEY",
  "BEGIN OpenVPN Static key V1",
}

local forbidden_files = {
  "secrets.nix",
}

local function get_staged_additions()
  local pid = assert(io.popen("git diff-index -p --cached --no-color HEAD"))
  local out = {}
  for line in pid:lines() do
    if line:sub(1, 1) == "+" then
      out[#out + 1] = line
    end
  end
  pid:close()
  return out
end

local function get_staged_files()
  local pid = assert(io.popen("git diff-index --name-only --cached --no-color HEAD"))
  local out = {}
  for line in pid:lines() do
    out[#out + 1] = line
  end
  pid:close()
  return out
end

local function updates_secret_by_pattern(line, patterns)
  local lower = line:lower()
  for _, pattern in ipairs(patterns) do
    if string.find(lower, pattern) ~= nil then
      return true
    end
  end
  return false
end

local function updates_secret_by_fixed(line, substrings)
  for _, substring in ipairs(substrings) do
    if string.find(line, substring, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local function check_forbidden_files()
  local updated_files = get_staged_files()
  for _, updated_file in ipairs(updated_files) do
    for _, forbidden_file in ipairs(forbidden_files) do
      local _, match_end, _ = string.find(updated_file, forbidden_file, 1, true)
      if match_end == string.len(updated_file) then
        print(string.format("Found forbidden file in commit '%s'", forbidden_file))
        os.exit(1)
      end
    end
  end
end

local function check_forbidden_content()
  local added_lines = get_staged_additions()
  local secret_lines = {}
  for _, line in ipairs(added_lines) do
    if updates_secret_by_pattern(line, secret_patterns) or updates_secret_by_fixed(line, key_file_headers) then
      secret_lines[#secret_lines + 1] = line
    end
  end
  if #secret_lines > 0 then
    print("Potential secret updates found in lines:")
  else
    os.exit(0)
  end
  for _, line in ipairs(secret_lines) do
    print(line)
  end
  io.write("\nDo you wish to proceed? [y/N]")
  local response = io.read("*l")
  if response == "y" then
    os.exit(0)
  end
  os.exit(1)
end

local function main()
  check_forbidden_files()
  check_forbidden_content()
end

main()
