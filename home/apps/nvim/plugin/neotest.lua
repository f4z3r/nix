local os = require("os")
local string = require("string")

local neotest_ns = vim.api.nvim_create_namespace("neotest")

vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

local neotest = require("neotest")
local home = os.getenv("HOME")

neotest.setup({
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
  adapters = {
    -- FIX(@f4z3r): this is quite invasive
    -- require("neotest-golang"),
    require("neotest-python"),
    require("neotest-rust"),
    require("neotest-busted")({
      -- Leave as nil to let neotest-busted automatically find busted
      busted_command = string.format("%s/.local/share/nvim/busted", home),
      -- busted_args = { "--shuffle-files" },
      -- busted_paths = { "my/custom/path/?.lua" },
      -- busted_cpaths = { "my/custom/path/?.so" },
      -- local_luarocks_only = true,
      -- parametric_test_discovery = false,
    }),
  },
})
