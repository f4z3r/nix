vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
  opup_border_style = "rounded",
  default_component_configs = {
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          "worktrees",
          ".git",
          "tags",
        },
      },
    },
    git_status = {
      symbols = {
        renamed = "󰁕",
        deleted   = "",
        unstaged = "󰄱",
        untracked = "",
        ignored   = "",
        staged    = "",
        conflict  = "",
      },
    },
  },
  source_selector = {
    sources = {
      { source = "filesystem", display_name = " 󰉓 Files " },
      { source = "git_status", display_name = " 󰊢 Git " },
    },
  },
  -- Other options ...
})
