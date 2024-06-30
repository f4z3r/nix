local math = require("math")
local string = require("string")
local table = require("table")

local function tostring_lowercase(n)
  local t = {}
  while n > 0 do
    t[#t + 1] = string.char(0x61 + (n - 1) % 26)
    n = math.floor((n - 1) / 26)
  end
  return table.concat(t):reverse()
end

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
          code_block = {
            width = "content",
            spell_check = false,
          },
          heading = {
            icons = { "", "󰪥", "󰻂", "󰺕", "○" },
          },
          quote = {
            icons = { "┊" },
          },
          ordered = {
            icons = {
              tostring_lowercase,
              function(idx)
                return tostring_lowercase(idx):upper()
              end,
              tostring,
              tostring_lowercase,
              function(idx)
                return tostring_lowercase(idx):upper()
              end,
              tostring,
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
          -- remap todo cycling due to control space being taken
           keybinds.remap_event("norg", "n", "<C-t>", "core.qol.todo_items.todo.task_cycle")
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
        create_todo_parents = false,
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
    ["core.integrations.telescope"] = {
      config = {
        insert_file_link = {
          show_title_preview = false,
        },
      },
    },
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
