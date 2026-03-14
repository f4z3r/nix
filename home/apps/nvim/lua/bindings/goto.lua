-- Goto bindings

local leader = "<leader>g"

local mappings = {
  {
    mode = "n",
    suffix = "g",
    command = function()
      require("grapple").toggle_tags()
    end,
    desc = "Show grapple list",
  },
  {
    mode = "n",
    suffix = "aa",
    command = function()
      require("grapple").toggle_tags({ scope = "git" })
    end,
    desc = "Show git-scoped grapple list",
  },
  {
    mode = "n",
    suffix = "c",
    command = function()
      require("grapple").reset()
    end,
    desc = "Clear grapple list",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

for idx, key in ipairs({ "n", "e", "i", "o" }) do
  vim.keymap.set("n", leader .. key, function()
    require("grapple").untag({ index = idx })
    require("grapple").tag({ index = idx, name = key })
  end, { desc = string.format("Create tag index %s in grapple", idx) })

  vim.keymap.set("n", leader .. "a" .. key, function()
    require("grapple").untag({ index = idx, scope = "git" })
    require("grapple").tag({ index = idx, name = key, scope = "git" })
  end, { desc = string.format("Create global (not branch linked) tag index %s in grapple", idx) })

  vim.keymap.set("n", "<leader>" .. key, function()
    require("grapple").select({ index = idx })
  end, { desc = string.format("Switch to item %s in grapple index", idx) })
end
