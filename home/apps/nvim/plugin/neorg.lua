require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes/",
        },
        index = "index.norg",
        default_workspace = "notes",
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    }
    -- defaults:
    -- "core.defaults",
    -- "core.autocommands",
    -- "core.clipboard",
    -- "core.clipboard.code-blocks",
    -- "core.esupports.hop",
    -- "core.esupports.indent",
    -- "core.esupports.metagen",
    -- "core.integrations.treesitter",
    -- "core.itero",
    -- "core.journal",
    -- "core.keybinds",
    -- "core.looking-glass",
    -- "core.mode",
    -- "core.neorgcmd",
    -- "core.pivot",
    -- "core.promo",
    -- "core.qol.toc",
    -- "core.qol.todo_items",
    -- "core.storage",
    -- "core.tangle",
    -- "core.todo-introspector"
    -- ["core.syntax"] = {},
    -- ["core.highlight"] = {},
    -- ["core.promo"] = {}, -- indenting
    -- ["core.itero"] = {}, -- indenting in insert
  },
})
