-- Window bindings

local leader = "<leader>w"

local mappings = {
  {
    mode = "n",
    suffix = "q",
    command = "<cmd>q<cr>",
    desc = "Close the current window",
  },
  {
    mode = "n",
    suffix = "v",
    command = "<cmd>vsplit<cr>",
    desc = "Create vertical split",
  },
  {
    mode = "n",
    suffix = "|",
    command = "<cmd>vsplit<cr>",
    desc = "Create vertical split",
  },
  {
    mode = "n",
    suffix = "s",
    command = "<cmd>split<cr>",
    desc = "Create horizontal split",
  },
  {
    mode = "n",
    suffix = "-",
    command = "<cmd>split<cr>",
    desc = "Create horizontal split",
  },
  {
    mode = "n",
    suffix = "R",
    command = "<c-w>=",
    desc = "Resize windows",
  },
  {
    mode = "n",
    suffix = "rk",
    command = "5<c-w>-",
    desc = "Resize window down",
  },
  {
    mode = "n",
    suffix = "rn",
    command = "5<c-w>+",
    desc = "Resize window up",
  },
  {
    mode = "n",
    suffix = "rh",
    command = "5<c-w><",
    desc = "Resize window left",
  },
  {
    mode = "n",
    suffix = "rl",
    command = "5<c-w>>",
    desc = "Resize window right",
  },
  {
    mode = "n",
    suffix = "l",
    command = "<c-w>lzH",
    desc = "Move to east window",
  },
  {
    mode = "n",
    suffix = "h",
    command = "<c-w>hzH",
    desc = "Move to west window",
  },
  {
    mode = "n",
    suffix = "n",
    command = "<c-w>jzH",
    desc = "Move to south window",
  },
  {
    mode = "n",
    suffix = "w",
    command = "<c-w>w",
    desc = "Move to last window",
  },
  {
    mode = "n",
    suffix = "k",
    command = "<c-w>kzH",
    desc = "Move to north window",
  },
  {
    mode = "n",
    suffix = "o",
    command = function()
      vim.cmd("%bd|e#|bd#|'\"")
    end,
    desc = "Keep only the current window",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
