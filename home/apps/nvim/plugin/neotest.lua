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

neotest.setup({
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
  adapters = {
    require("neotest-go"),
    require("neotest-python"),
    require("neotest-rust"),
  },
})
