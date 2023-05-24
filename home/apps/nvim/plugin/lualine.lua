local colors = {
  red    = '#ea6962',
  yellow = '#d8a657',
  green  = '#a9b665',
  blue   = '#7daea3',

  invis  = '#282828',
  fg     = '#d4be98',
  bg     = '#3a3735',
}

if vim.env.NIX_THEME == "light" then
  colors = {
    red    = '#c14a4a',
    yellow = '#b47109',
    green  = '#6c782e',
    blue   = '#45707a',

    invis  = '#fbf1c7',
    fg     = '#654735',
    bg     = '#f2e5bc',
  }
end

local bubbles_theme = {
  normal = {
    a = { fg = colors.invis, bg = colors.green },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.invis, bg = colors.invis },
  },

  insert = { a = { fg = colors.invis, bg = colors.blue } },
  visual = { a = { fg = colors.invis, bg = colors.yellow } },
  replace = { a = { fg = colors.invis, bg = colors.red } },

  inactive = {
    a = { fg = colors.fg, bg = colors.invis },
    b = { fg = colors.fg, bg = colors.invis },
    c = { fg = colors.invis, bg = colors.invis },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      'filename',
      { 'branch', icon = '', },
    },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
