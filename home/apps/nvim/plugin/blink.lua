local blink = require("blink.cmp")

blink.setup({
  completion = {
    keyword = { range = "full" },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },

    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    menu = {
      border = "single",
      auto_show = true,
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = { border = "single" },
    },
    ghost_text = {
      enabled = true,
    },
  },

  sources = {
    default = function(ctx)
      local success, node = pcall(vim.treesitter.get_node)
      if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
        return { "buffer", "emoji", "nerdfont" }
      elseif vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype) then
        return { "snippets", "path", "buffer", "emoji", "nerdfont" }
      else
        return { "lsp", "path", "snippets", "buffer" }
      end
    end,

    providers = {
      snippets = {
        should_show_items = function(ctx)
          return ctx.trigger.initial_kind ~= "trigger_character"
        end,
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15,
        opts = { insert = true },
      },
      nerdfont = {
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15,
        opts = { insert = true },
      },
    },

    min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 2 or 0
    end,
  },

  snippets = {
    preset = "luasnip",
  },

  signature = {
    enabled = true,
    window = { border = "single" },
  },

  keymap = {
    preset = "none",
    ["<C-d>"] = {
      function(cmp)
        cmp.scroll_documentation_down(4)
      end,
    },
    ["<C-u>"] = {
      function(cmp)
        cmp.scroll_documentation_up(4)
      end,
    },
    ["<C-space>"] = { "accept" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<tab>"] = { "select_and_accept", "fallback" },
  },
})
