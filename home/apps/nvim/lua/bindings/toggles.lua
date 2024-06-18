-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = "<leader>t"

local function toggle_conceal()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end

local mappings = {
  {
    mode = "n",
    suffix = "t",
    command = function()
      require("trouble").toggle()
    end,
    desc = "Toggle trouble list",
  },
  {
    mode = "n",
    suffix = "z",
    command = require("zen-mode").toggle,
    desc = "Toggle zen mode",
  },
  {
    mode = "n",
    suffix = "d",
    command = function()
      require("trouble").toggle("document_diagnostics")
    end,
    desc = "Toggle document diagnostics",
  },
  {
    mode = "n",
    suffix = "D",
    command = function()
      require("trouble").toggle("workspace_diagnostics")
    end,
    desc = "Toggle workspace diagnostics",
  },
  {
    mode = "n",
    suffix = "m",
    command = require("maximize").toggle,
    desc = "Toggle maximization",
  },
  {
    mode = "n",
    suffix = "r",
    command = require("overseer").toggle,
    desc = "Toggle task runner",
  },
  {
    mode = "n",
    suffix = "c",
    command = toggle_conceal,
    desc = "Toggle conceal",
  },
  {
    mode = "n",
    suffix = "C",
    command = "<cmd>TSContextToggle<cr>",
    desc = "Toggle context",
  },
  {
    mode = "n",
    suffix = "s",
    command = "<cmd>SymbolsOutline<cr>",
    desc = "Toggle document symbol outline",
  },
  {
    mode = "n",
    suffix = "S",
    command = require('treesj').toggle,
    desc = "Toggle split/join",
  },
  {
    mode = "n",
    suffix = "b",
    command = function()
      require("neo-tree.command").execute({
        source = "buffers",
        toggle = true,
        action = "focus",
        reveal = true,
      })
    end,
    desc = "Toggle buffer sidepane",
  },
  {
    mode = "n",
    suffix = "n",
    command = function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle test outputs",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
