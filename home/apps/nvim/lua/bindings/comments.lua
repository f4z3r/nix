-- Comment bindings

local leader = "<leader>c"

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

local mappings = {
  {
    mode = "n",
    suffix = "c",
    command = function()
      require("Comment.api").toggle.linewise.current()
    end,
    desc = "Toggle current line to linewise comment",
  },
  {
    mode = "x",
    suffix = "c",
    command = function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end,
    desc = "Toggle visual selection to linewise comment",
  },
  {
    mode = "n",
    suffix = "b",
    command = function()
      require("Comment.api").toggle.blockwise.current()
    end,
    desc = "Toggle current line to blockwise comment",
  },
  {
    mode = "x",
    suffix = "b",
    command = function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.blockwise(vim.fn.visualmode())
    end,
    desc = "Toggle visual selection to blockwise comment",
  },
  {
    mode = "n",
    suffix = "a",
    command = function()
      require("neogen").generate()
    end,
    desc = "Add neogen comment",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
