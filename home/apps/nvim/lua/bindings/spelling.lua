-- Spelling binding

local leader = "<leader>s"

local mappings = {
  {
    mode = "n",
    suffix = "e",
    command = "<cmd>setlocal spell wrap<cr>",
    desc = "Enable english spelling",
  },
  {
    mode = "n",
    suffix = "d",
    command = "<cmd>setlocal spell spl=de wrap<cr>",
    desc = "Enable german spelling",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
