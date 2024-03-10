local dashboard = require("alpha.themes.startify")

dashboard.section.header.val = {
  [[ ⠀⢠⣶⣿⣿⣗⡢⠀⠀⠀⠀⠀⠀⢤⣒⣿⣿⣷⣆⠀]],
  [[⠀⠋⠉⠉⠙⠻⣿⣷⡄⠀⠀⠀⣴⣿⠿⠛⠉⠉⠉⠃⠀]],
  [[⠀⠀⢀⡠⢤⣠⣀⡹⡄⠀⠀⠀⡞⣁⣤⣠⠤⡀⠀⠀⠀]],
  [[⢐⡤⢾⣿⣿⢿⣿⡿⠀⠀⠀⠀⠸⣿⣿⢿⣿⣾⠦⣌⠀]],
  [[⠁⠀⠀⠀⠉⠈⠀⠀⣸⠀⠀⢰⡀⠀⠈⠈⠀⠀⠀⠀⠁]],
  [[⠀⠀⠀⠀⠀⠀⣀⡔⢹⠀⠀⢸⠳⡄⡀⠀⠀⠀⠀⠀⠀]],
  [[⠸⡦⣤⠤⠒⠋⠘⢠⡸⣀⣀⡸⣠⠘⠉⠓⠠⣤⢤⡞⠀]],
  [[⠀⢹⡜⢷⣄⠀⣀⣀⣾⡶⢶⣷⣄⣀⡀⢀⣴⢏⡾⠁⠀]],
  [[⠀⠀⠹⡮⡛⠛⠛⠻⠿⠥⠤⠽⠿⠛⠛⠛⣣⡾⠁⠀⠀]],
  [[⠀⠀⠀⠙⢄⠁⠀⠀⠀⣄⣀⡄⠀⠀⠀⢁⠞⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠂⠀⠀⠀⢸⣿⠀⠀⠀⠠⠂⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}

dashboard.section.header.opts = {
  position = "center",
  hl = "@boolean",
  shrink_margin = false,
}

dashboard.section.top_buttons.val = {
  dashboard.button("f", "  Files", ':lua require("telescope.builtin").find_files()<cr>'),
  dashboard.button("g", "󰊳  Grep", ':lua require("telescope.builtin").live_grep()<cr>'),
  dashboard.button(
    "t",
    "󱋡  Temp File",
    ':lua vim.cmd(string.format("e %s", require("lazy.utils").get_temp_file()))<cr>'
  ),
  dashboard.button("a", "󰃭  Agenda", ':lua require("orgmode").action("agenda.prompt")<cr>'),
  dashboard.button(
    "o",
    "  Org File",
    ':lua vim.cmd(string.format("e %s", require("lazy.utils").get_random_org()))<cr>'
  ),
}
dashboard.section.bottom_buttons.val = {
  dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
}

require("alpha").setup(dashboard.config)
