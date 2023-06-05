local footer = { "", "" }
for _, line in ipairs(require("lazy.utils").quote()) do
  footer[#footer + 1] = line
end

require('dashboard').setup({
  theme = 'hyper',
  config = {
    header = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣶⣦⣴⣿⣷⣆",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⡿⠁",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⠿⠋⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡘⠁⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⠇⠀⠀⠀⠀⠀",
      "⠀⣠⣴⣶⣾⢶⡖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀",
      "⢰⣿⣿⣿⡃⠀⠹⠃⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠸⣿⣿⣿⣷⣦⠀⠀⠀⠀⠀⣀⣴⣿⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠙⠿⣿⠿⠟⠋⣀⣤⣾⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⢠⣾⡗⠠⡀⠙⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⢈⣿⢠⣾⠀⠀⠰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠘⢣⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⢿⣿⣿⣿⡄⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣼⡬⣿⣿⣿⣿⡔⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣿⣿⣿⣿⣿⣿⣿⡴⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⢸⣿⣿⣿⣿⣿⣿⣿⣿⣾⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠛⠻⢿⣿⣿⣿⠿⠿⠿⠿⠛⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⣾⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠰⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⣿⣿⣿⣦⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "",
      "",
    },
    disable_move = true,
    week_header = {
      enable = false,
    },
    packages = {
      enable = false,
    },
    hide = {
      statusline = true,
      tabline = true,
      winbar = true,
    },
    shortcut = {
      {
        desc = ' Files',
        group = '@keyword',
        action = function() require('telescope.builtin').find_files() end,
        key = 'f',
      },
      {
        desc = '󰊳 Grep',
        group = '@constant',
        action = function() require('telescope.builtin').live_grep() end,
        key = 'g'
      },
      {
        desc = '󱋡 Temp File',
        group = '@debug',
        action = function() vim.cmd(string.format('e %s', require('lazy.utils').get_temp_file())) end,
        key = 't',
      },
      {
        desc = ' Symbols',
        group = '@number',
        action = function() require('telescope.builtin').tags() end,
        key = 's',
      },
      {
        desc = ' Orgmode',
        group = '@parameter',
        action = function() require('orgmode').action('agenda.prompt') end,
        key = 'a',
      },
    },
    footer = footer,
  },
})
