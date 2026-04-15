-- Action bindings
--
-- These are currently defined in diagnostics.lua
-- For markdown table formatting, see after/ftplugin/markdown.lua
-- For http request handling, see after/ftplugin/http.lua

local leader = "<leader>a"

local mappings = {
  {
    mode = "n",
    suffix = "f",
    command = function()
      vim.lsp.buf.format({ async = true, timeout_ms = 1000 })
    end,
    desc = "Format current buffer",
  },
  {
    mode = { "n", "x" },
    suffix = "o",
    command = function()
      require("opencode").ask("@this: ", { submit = true })
    end,
    desc = "Ask opencode",
  },
  {
    mode = { "n", "x" },
    suffix = "s",
    command = function()
      require("opencode").select()
    end,
    desc = "Execute selected opencode action",
  },
  {
    mode = { "n" },
    suffix = "b",
    command = function()
      require("gitsigns").blame()
    end,
    desc = "Show git blame",
  },
  {
    mode = { "n" },
    suffix = "g",
    command = function()
      require("gitsigns").preview_hunk_inline()
    end,
    desc = "Preview current hunk",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
