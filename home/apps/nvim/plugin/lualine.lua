local g_colors = require("gruvbox-material.colors")
local gruvbox_colors = g_colors.get(vim.o.background, "medium")

local colors = {
  red = gruvbox_colors.red,
  orange = gruvbox_colors.orange,
  yellow = gruvbox_colors.yellow,
  green = gruvbox_colors.green,
  aqua = gruvbox_colors.aqua,
  blue = gruvbox_colors.blue,
  purple = gruvbox_colors.purple,

  invis = "NONE",
  fg = gruvbox_colors.fg0,
  bg = gruvbox_colors.bg_statusline1,
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.green },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.invis, bg = colors.invis },
    x = { fg = colors.bg, bg = colors.purple },
  },

  insert = { a = { fg = colors.bg, bg = colors.blue } },
  visual = { a = { fg = colors.bg, bg = colors.yellow } },
  replace = { a = { fg = colors.bg, bg = colors.red } },

  inactive = {
    a = { fg = colors.fg, bg = colors.invis },
    b = { fg = colors.fg, bg = colors.invis },
    c = { fg = colors.fg, bg = colors.invis },
    x = { fg = colors.fg, bg = colors.invis },
  },
}

require("lualine").setup({
  options = {
    theme = bubbles_theme,
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
    lualine_c = {},
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
