-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = "<leader>t"

local function toggle_conceal()
  local conceal = vim.opt_local.conceallevel:get()
  if conceal > 0 then
    vim.opt_local.conceallevel = 0
  else
    vim.opt_local.conceallevel = 2
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
    suffix = "T",
    command = function()
      require("timerly").toggle()
    end,
    desc = "Toggle timerly timer",
  },
  {
    mode = "n",
    suffix = "z",
    command = function()
      require("zen-mode").toggle()
      vim.opt_local.wrap = require("zen-mode.view").is_open()
    end,
    desc = "Toggle zen mode",
  },
  {
    mode = "n",
    suffix = "d",
    command = function()
      require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } })
    end,
    desc = "Toggle document diagnostics",
  },
  {
    mode = "n",
    suffix = "D",
    command = function()
      require("trouble").toggle("diagnostics")
    end,
    desc = "Toggle workspace diagnostics",
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
    suffix = "m",
    command = require("treesj").toggle,
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
  {
    mode = "n",
    suffix = "w",
    command = function()
      vim.opt_local.wrap = not vim.opt_local.wrap:get()
    end,
    desc = "Toggle wrapping",
  },
  {
    mode = "n",
    suffix = "W",
    command = function()
      require("visual-whitespace").toggle()
    end,
    desc = "Toggle visual whitespace",
  },
  {
    mode = "n",
    suffix = "i",
    command = function()
      require("trouble").toggle({
        mode = "lsp",
        win = { type = "split", position = "right", size = 0.4 },
        focus = false,
      })
    end,
    desc = "Toggle information on lsp item",
  },
  {
    mode = "n",
    suffix = "I",
    command = function()
      local image = require("image")
      if image.is_enabled() then
        image.disable()
      else
        image.enable()
      end
    end,
    desc = "Toggle image rendering",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
