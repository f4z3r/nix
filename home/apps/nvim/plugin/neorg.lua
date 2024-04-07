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
    },
    ["core.esupports.metagen"] = {
      config = {
        type = "empty", -- generate on new empty files
      },
    },
    ["core.export"] = {}, -- allow exporting to md
    ["core.highlights"] = {
      config = {
        highlights = {
          headings = {
            ["1"] = "+Yellow",
            ["2"] = "+Orange",
            ["3"] = "+Red",
            ["4"] = "+Green",
            ["5"] = "+Blue",
            ["6"] = "+Purple",
          },
          markup = {
            verbatim = "+Purple",
          },
          links = {
            location = {
              heading = {
                ["1"] = "+Yellow",
                ["2"] = "+Orange",
                ["3"] = "+Red",
                ["4"] = "+Green",
                ["5"] = "+Blue",
                ["6"] = "+Purple",
              },
            },
          },
        },
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        hook = function(keybinds)
          local leader = keybinds.leader
          -- remap j -> n
          keybinds.remap_key("traverse-heading", "n", "j", "n")
          keybinds.remap_key("traverse-links", "n", "j", "n")
          -- toc like symbols outline
          keybinds.map("norg", "n", "<leader>ts", "<cmd>Neorg toc split<cr>")
          -- edit code block in different pannel
          keybinds.map("norg", "n", leader .. "e", "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>")
          -- unmap standard inserts
          keybinds.unmap("norg", "n", leader .. "id")
          -- insert stuff via telescope
          keybinds.map_event("norg", "i", "<C-i>", "core.integrations.telescope.insert_file_link")
          keybinds.map_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_link")
          keybinds.map_event("norg", "n", "<leader>/n", "core.integrations.telescope.find_linkable")
          keybinds.map_event("norg", "n", "<leader>nh", "core.integrations.telescope.search_headings")
          keybinds.map_event("norg", "n", "<leader>/H", "core.integrations.telescope.search_headings")
          keybinds.map_event("norg", "n", "<leader>nb", "core.integrations.telescope.find_backlinks")
          keybinds.map_event("norg", "n", "<leader>/b", "core.integrations.telescope.find_backlinks")
        end,
      },
    },
    ["core.journal"] = {
      config = {
        workspace = "notes",
      },
    },
    ["core.qol.toc"] = {
      config = {
        close_after_use = true,
      },
    },
    ["core.qol.todo_items"] = {
      config = {
        create_todo_parents = true,
        order = {
          {
            "undone",
            " ",
          },
          {
            "pending",
            "-",
          },
          {
            "done",
            "x",
          },
        },
      },
    },
    -- integrations
    ["core.integrations.telescope"] = {},
  },
})
