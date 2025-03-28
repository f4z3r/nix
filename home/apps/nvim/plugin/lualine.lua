local g_colors = require("gruvbox-material.colors")
local navic = require("nvim-navic")
local theme = require("gruvbox-material.lualine").theme("medium")
local colors = g_colors.get(vim.o.background, "medium")

theme.normal["x"] = { fg = colors.bg_statusline1, bg = colors.purple }
theme.insert["x"] = { fg = colors.bg_statusline1, bg = colors.purple }
theme.visual["x"] = { fg = colors.bg_statusline1, bg = colors.purple }
theme.replace["x"] = { fg = colors.bg_statusline1, bg = colors.purple }
theme.command["x"] = { fg = colors.bg_statusline1, bg = colors.purple }
theme.inactive["x"] = { fg = colors.fg0, bg = "NONE" }

require("lualine").setup({
  options = {
    theme = theme,
    globalstatus = true,
    component_separators = "|",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" } },
    },
    lualine_b = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      },
    },
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end,
        -- color = { fg = gruvbox_colors.fg0, bg = gruvbox_colors.bg0 },
        padding = { left = 1, right = 0 },
      },
    },
    lualine_x = {
      { "branch", icon = "", separator = { left = "" } },
    },
    lualine_y = {
      { "filetype", separator = { left = "" }, padding = { left = 2, right = 1 } },
      "overseer",
      "progress",
    },
    lualine_z = {
      { "location", separator = { right = "" } },
    },
  },
  inactive_sections = {
    lualine_a = { "%F" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
})
