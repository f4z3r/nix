-- Movement bindings

local mappings = {
  {
    mode = { "n", "x" },
    suffix = "n",
    command = "j",
  },
  {
    mode = { "n", "x" },
    suffix = "N",
    command = "J",
  },
  {
    mode = { "n", "x" },
    suffix = "<c-n>",
    command = "10j",
  },
  {
    mode = { "n", "x" },
    suffix = "<c-k>",
    command = "10k",
  },
  {
    mode = { "n", "x" },
    suffix = "<c-h>",
    command = "zH_",
  },
  {
    mode = "o",
    suffix = "<c-h>",
    command = "_",
  },
  {
    mode = { "n", "x", "o" },
    suffix = "<c-l>",
    command = "$",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, mapping.suffix, mapping.command, mapping.opts)
end
