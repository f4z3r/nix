#!/usr/bin/env luajit

local os = require("os")
local io = require("io")
local string = require("string")

local NOTES_DIR = "notes"
local TITLE_PREFIX = "title: "

local function get_title(link)
  for line in io.lines(link) do
    if line:match(TITLE_PREFIX) then
      return line:sub(#TITLE_PREFIX + 1, -1)
    end
  end
  assert(false, "failed to find title in norg document")
end

local function main()
  local link = arg[1]
  local home = os.getenv("HOME")
  local notes_dir = home .. "/" .. NOTES_DIR
  local relative_link = link:sub(#notes_dir + 1, -1)
  local title = get_title(link)
  print(string.format("{:$%s:}[%s]", relative_link, title))
end

main()
