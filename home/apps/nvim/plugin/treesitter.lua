require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  auto_install = false,
  parser_install_dir = "~/.config/nvim/parsers/",
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = "rainbow-delimiters",
    strategy = require("rainbow-delimiters").strategy.global,
  },
  indent = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
        ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
        ["ai"] = { query = "@block.outer", desc = "Select outer part of a block region" },
        ["ii"] = { query = "@block.inner", desc = "Select inner part of a block region" },
        ["aC"] = { query = "@comment.outer", desc = "Select outer part of a comment region" },
        ["iC"] = { query = "@comment.inner", desc = "Select inner part of a comment region" },
        -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
    },
  },
})
