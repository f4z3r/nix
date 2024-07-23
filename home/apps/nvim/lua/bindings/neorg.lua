-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = "<leader>n"

local mappings = {
  {
    mode = "n",
    suffix = "i",
    command = "<cmd>Neorg workspace notes<cr>",
    desc = "Open neorg inbox",
  },
  {
    mode = "n",
    suffix = "n",
    command = "<cmd>Neorg journal today<cr>",
    desc = "Open journal today",
  },
  {
    mode = "n",
    suffix = "y",
    command = "<cmd>Neorg journal yesterday<cr>",
    desc = "Open journal for yesterday",
  },
  {
    mode = "n",
    suffix = "t",
    command = "<cmd>Neorg journal tomorrow<cr>",
    desc = "Open journal for tomorrow",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  desc = "Load keyboard bindings for norg files",
  group = vim.api.nvim_create_augroup("NorgKeybindings", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<C-t>", "<plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true, silent = true })
    -- toc like symbols outline
    vim.keymap.set("n", "<leader>ts", "<cmd>Neorg toc right<cr>", { buffer = true })
    -- edit code block in different pannel
    vim.keymap.set(
      "n",
      leader .. "e",
      "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>",
      { buffer = true }
    )
    -- insert stuff via telescope
    vim.keymap.set("i", "<C-l>", "<cmd>Telescope neorg insert_file_link<cr>", { buffer = true })
    -- neorg return
    vim.keymap.set("n", leader .. "r", "<cmd>Neorg return<cr>", { buffer = true })
    -- insert metadata
    vim.keymap.set("n", leader .. "m", "<cmd>Neorg inject-metadata<cr>", { buffer = true })
  end,
})
