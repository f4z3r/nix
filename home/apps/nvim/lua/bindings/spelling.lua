-- Spelling binding

local leader = "<leader>s"

local mappings = {
  {
    mode = "n",
    suffix = "s",
    command = function()
      vim.opt_local.spell = not vim.opt_local.spell:get()
      vim.opt_local.wrap = vim.opt_local.spell:get()
    end,
    desc = "Toggle spelling and word wrapping",
  },
  {
    mode = "n",
    suffix = "e",
    command = function()
      vim.opt_local.spl = "en"
    end,
    desc = "Set spell language to English",
  },
  {
    mode = "n",
    suffix = "d",
    command = function()
      vim.opt_local.spl = "de"
    end,
    desc = "Set spell language to German",
  },
  {
    mode = "n",
    suffix = "f",
    command = function()
      vim.opt_local.spl = "fr"
    end,
    desc = "Set spell language to French",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
