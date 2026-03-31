-- File bindings

local leader = "<leader>f"

local mappings = {
  {
    mode = "n",
    suffix = "s",
    command = "<cmd>update<cr>",
    desc = "Save file",
  },
  {
    mode = "n",
    suffix = "r",
    command = "<cmd>checktime %<cr>",
    desc = "Refresh file",
  },
  {
    mode = "n",
    suffix = "t",
    command = function()
      vim.cmd(string.format("e %s", require("lazy.utils").get_temp_file()))
    end,
    desc = "Open temp file",
  },
  {
    mode = "n",
    suffix = "f",
    command = function()
      require("tv").tv_channel("dirs")
    end,
    desc = "Open a directory in the workspace",
  },
}

vim.keymap.set("n", "<c-p>", function()
  require("tv").tv_channel("files")
end, {
  desc = "Search a file with tv",
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
