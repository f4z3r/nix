require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = {
        icons = {
          todo = {
            urgent = {
              icon = "",
            },
          },
          heading = {
            icons = {
              "",
              "󰪥",
              "󰻂",
              "󰺕",
              "○",
            },
          },
        },
      },
    },
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
        timezone = "implicit-local",
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
          keybinds.map_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_file_link")
          keybinds.map_event("norg", "n", "<leader>/n", "core.integrations.telescope.find_linkable")
          keybinds.map_event("norg", "n", "<leader>nh", "core.integrations.telescope.search_headings")
          keybinds.map_event("norg", "n", "<leader>/H", "core.integrations.telescope.search_headings")
          keybinds.map_event("norg", "n", "<leader>nb", "core.integrations.telescope.find_backlinks")
          keybinds.map_event("norg", "n", "<leader>/b", "core.integrations.telescope.find_backlinks")
          -- neorg return
          keybinds.map("norg", "n", "<leader>nr", "<cmd>Neorg return<cr>")
          -- insert metadata
          keybinds.map("norg", "n", "<leader>nm", "<cmd>Neorg inject-metadata<cr>")
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
    ["external.templates"] = {
      config = {
        templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
        keywords = {
          NOW = function()
            return require("luasnip").text_node(os.date("%Y-%m-%dT%H:%M:%S"))
          end,
        },
      },
    },
  },
})

local group = vim.api.nvim_create_augroup("NeorgLoadTemplateGroup", { clear = true })

local is_buffer_empty = function(buffer)
  local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  return not (#content > 1 or content[1] ~= "")
end

local callback = function(args)
  vim.schedule(function()
    if not is_buffer_empty(args.buf) then
      return
    end

    if string.find(args.file, "/journal/") then
      vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
    else
      vim.api.nvim_cmd({ cmd = "Neorg", args = { "inject-metadata" } }, {})
    end
  end)
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufNew" }, {
  desc = "Load template on new norg files",
  pattern = "*.norg",
  callback = callback,
  group = group,
})
