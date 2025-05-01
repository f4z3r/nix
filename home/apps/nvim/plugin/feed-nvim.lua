require("feed").setup({
  ui = {
    tags = {
      color = "String",
      format = function(id, db)
        local icons = {
          news = "󱀄",
          security = "",
          tech = "",
          rust = "󱘗",
          neovim = "",
          kubernetes = "󱃾",
          unread = "󰺕",
          read = "",
          star = "",
        }

        local get_icon = function(name)
          if icons[name] then
            return icons[name]
          end
          return name
        end

        local tags = vim.tbl_map(get_icon, db:get_tags(id))
        table.sort(tags)
        return "[" .. table.concat(tags, ", ") .. "]"
      end,
    },
  },
  order = { "date", "feed", "tags", "title", "reading_time" },
  reading_time = {
    color = "Comment",
    format = function(id, db)
      local cpm = 1000
      local content = db:get(id):gsub("%s+", " ")
      local chars = vim.fn.strchars(content)
      local time = math.ceil(chars / cpm)
      return string.format("(%s min)", time)
    end,
  },
  feeds = {
    -- {
    --   "https://neovim.io/news.xml",
    --   name = "Neovim News",
    --   tags = { "tech", "neovim" },
    -- },
    {
      "https://dev.to/feed/ipt",
      name = "IPT Dev.to",
      tags = { "tech", "work" },
    },
    {
      "https://hnrss.org/newest?points=100",
      name = "Hacker News",
      tags = { "tech" },
    },
    {
      "https://www.wired.com/feed/category/security/latest/rss",
      name = "WIRED Security",
      tags = { "tech", "news", "security" },
    },
    {
      "https://www.wired.com/feed/category/business/latest/rss",
      name = "WIRED Business",
      tags = { "news" },
    },
    -- {
    --   "https://feeds.feedburner.com/TheHackersNews?format=xml",
    --   name = "THN",
    --   tags = { "tech", "security" },
    -- },
    {
      "https://krebsonsecurity.com/feed/",
      name = "Krebs on Security",
      tags = { "tech", "security" },
    },
    -- {
    --   "https://this-week-in-rust.org/rss.xml",
    --   name = "This week in Rust",
    --   tags = { "tech", "rust" },
    -- },
    -- {
    --   "https://feeds.bbci.co.uk/news/world/rss.xml",
    --   name = "BBC World News",
    --   tags = { "tech" },
    -- },
    {
      "https://www.cncf.io/blog/feed/",
      name = "CNCF Blog",
      tags = { "tech", "kubernetes" },
    },
    -- three link formats are supported:
    -- "https://neovim.io/news.xml", -- Regular links
    -- "rsshub://rsshub://apnews/topics/apf-topnews", -- RSSHub links
    -- "neovim/neovim/releases", -- GitHub links
  },
})
