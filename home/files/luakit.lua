local luakit = require("luakit")
local settings = require("settings")
settings.window.home_page = "https://xkcd.com/"
settings.webview.enable_webgl = true
settings.session.always_save = true
settings.application.prefer_dark_mode = true
settings.webview.enable_webaudio = true
settings.webview.enable_java = false

-- Fuzzy Tabs
local lousy = require("lousy")
local escape = lousy.util.escape
local io = require("io")
local string = require("string")

local function print_to_file(filename, tabl)
  local fh = assert(io.open(filename, "w"))
  for _, row in ipairs(tabl) do
    fh:write(row.."\n")
  end
  fh:close()
end

local function fuzzy_tab(w)
  local rows = {}
  for _, view in ipairs(w.tabs.children) do
    if not view.uri then view.uri = " " end
    table.insert(rows, string.format("%d %s (%s)", w.tabs:indexof(view), escape(view.title), escape(view.uri)))
  end
  print_to_file("/tmp/luakit-tab-switch", rows)
  local fh = assert(io.popen("cat /tmp/luakit-tab-switch | rofi -i -dmenu"))
  local out = fh:read("*a")
  fh:close()
  local index = tonumber(string.match(out, "%d+"))
  os.remove("/tmp/luakit-tab-switch")
  if not index then return end
  w.last_active_tab = w.tabs:current()
  w.tabs:switch(index)
end

local modes = require("modes")
modes.add_cmds({
  { ":tabfuzzy", [[Open tab fuzzy searcher.]], function (w) fuzzy_tab(w) end },
})

-- Fuzzy Bookmarks
local bookmarks = require("bookmarks")
local function fuzzy_bookmarks(w)
  if not bookmarks.db then bookmarks.init() end
  local rows = bookmarks.db:exec("SELECT id, title, uri, tags FROM bookmarks")
  local data = {}
  local rofi_in = {}
  for _, row in ipairs(rows) do
    data[row.id] = row.uri
    local tags = ""
    if row.tags then
      tags = string.format("[%s] ", row.tags)
    end
    table.insert(rofi_in, string.format("%s %s %s(%s)", row.id, row.title, tags, row.uri))
  end
  print_to_file("/tmp/luakit-bookmark-open", rofi_in)
  local fh = assert(io.popen("cat /tmp/luakit-bookmark-open | rofi -i -dmenu"))
  local out = fh:read("*a")
  fh:close()
  os.remove("/tmp/luakit-bookmark-open")
  local index = tonumber(string.match(out, "%d+"))
  if not index then return end
  local uri = data[index]
  w.last_active_tab = w.tabs:current()
  w:new_tab(uri, { switch = true })
end

-- Fuzzy History
local history = require("history")
local function fuzzy_history(w)
  local rows = history.db:exec("SELECT id, title, uri FROM history ORDER BY last_visit DESC LIMIT 200")
  local data = {}
  local rofi_in = {}
  for _, row in ipairs(rows) do
    data[row.id] = row.uri
    table.insert(rofi_in, string.format("%s %s (%s)", row.id, row.title, row.uri))
  end
  print_to_file("/tmp/luakit-history-open", rofi_in)
  local fh = assert(io.popen("cat /tmp/luakit-history-open | rofi -i -dmenu"))
  local out = fh:read("*a")
  fh:close()
  local index = tonumber(string.match(out, "%d+"))
  os.remove("/tmp/luakit-history-open")
  if not index then return end
  local uri = data[index]
  w.last_active_tab = w.tabs:current()
  w:new_tab(uri, { switch = true })
end

-- Edit in neovim
local function open_in_neovim(content)
  local fh = assert(io.open("/tmp/luakit-content", "w"))
  fh:write(content)
  fh:close()
  os.execute("wezterm start --always-new-process nvim --noplugin /tmp/luakit-content")
  fh = assert(io.open("/tmp/luakit-content", "r"))
  local out = fh:read("*l")
  fh:close()
  os.remove("/tmp/luakit-content")
  return out
end

-- Editor
local editor = require("editor")
editor.editor_cmd = "wezterm start nvim {file} +{line}"

-- Key bindings
--- Normal
modes.add_binds("normal", {
  {
    "n",
    "Scroll the current page down.",
    function(w, m)
      w:scroll{ yrel =  settings.get_setting("window.scroll_step")*(m.count or 1) }
    end,
  },
  {
    "<C-q>",
    "Close all but current tab.",
    function(w)
      local current = w.tabs:current()
      -- need to loop backwards as index gets updated as we delete tabs
      for index = w.tabs:count(),1,-1 do
        if index ~= current then
          w:close_tab(w.tabs[index])
        end
      end
    end,
  },
  {
    "<C-c>",
    "Copy selected text.",
    function()
      luakit.selection.clipboard = luakit.selection.primary
    end,
  },
  {
    "<C-t>",
    "Switch to latest tab.",
    function(w)
      local current = w.tabs:current()
      if w.last_active_tab ~= nil then
        w:goto_tab(w.last_active_tab)
      end
      w.last_active_tab = current
    end,
  },
  {
    "gT",
    "Switch to previous tab.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w:prev_tab()
    end,
  },
  {
    "gt",
    "Switch to next tab.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w:next_tab()
    end,
  },
  {
    "<C-1>",
    "Switch to tab 1.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(1)
    end,
  },
  {
    "<C-2>",
    "Switch to tab 2.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(2)
    end,
  },
  {
    "<C-3>",
    "Switch to tab 3.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(3)
    end,
  },
  {
    "<C-4>",
    "Switch to tab 4.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(4)
    end,
  },
  {
    "<C-5>",
    "Switch to tab 5.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(5)
    end,
  },
  {
    "<C-6>",
    "Switch to tab 6.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(6)
    end,
  },
  {
    "<C-7>",
    "Switch to tab 7.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(7)
    end,
  },
  {
    "<C-8>",
    "Switch to tab 8.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(8)
    end,
  },
  {
    "<C-9>",
    "Switch to tab 9.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(9)
    end,
  },
  {
    "<C-0>",
    "Switch to tab 10.",
    function(w)
      w.last_active_tab = w.tabs:current()
      w.tabs:switch(10)
    end,
  },
  {
    "N",
    "Go to next tab.",
    function(w) w:next_tab() end,
  },
  {
    "%]t",
    "Go to next tab.",
    function(w) w:next_tab() end,
  },
  {
    "%[t",
    "Go to previous tab.",
    function(w) w:prev_tab() end,
  },
  {
    "T",
    "Fuzzy search tab.",
    fuzzy_tab,
  },
  {
    "b",
    "Fuzzy search bookmarks.",
    fuzzy_bookmarks,
  },
  {
    "q",
    "Enter qmarklist mode.",
    function(w) w:set_mode("qmarklist") end,
  },
  {
    "h",
    "Fuzzy search history.",
    fuzzy_history,
  },
  {
    "H",
    "Enter tabhistory mode.",
    function(w) w:set_mode("tabhistory") end,
  },
  {
    "O",
    "Open one or more urls based on current location.",
    function(w)
      local uri = open_in_neovim(w.view.uri or "")
      w:navigate(uri)
    end,
  },
  {
    "j",
    "Find next search result.",
    function(w, m)
      for _=1,m.count do
        w:search(nil, true)
        if w.search_state.by_view[w.view].ret == false then
          break
        end
      end
    end, {count=1},
  },
  {
    "J",
    "Find previous search result.",
    function(w, m)
      for _=1,m.count do
        w:search(nil, false)
        if w.search_state.by_view[w.view].ret == false then
          break
        end
      end
    end, {count=1},
  },
})

-- C-Y override
modes.add_binds("all", {{
  "<C-y>",
  "Return to normal mode.",
  function(w)
    w:set_prompt()
    w:set_mode()
  end,
}})

--- Tabmenu
modes.add_binds("tabmenu", {
  {
    "n",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
  {
    "<C-p>",
    "Move the menu row focus upwards.",
    function(w) w.menu:move_up() end,
  },
  {
    "<C-n>",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
})

--- Tabhistory
modes.add_binds("tabhistory", {
  {
    "n",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
  {
    "<C-p>",
    "Move the menu row focus upwards.",
    function(w) w.menu:move_up() end,
  },
  {
    "<C-n>",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
})

--- Qmarklist
modes.add_binds("qmarklist", {
  {
    "n",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
  {
    "<C-p>",
    "Move the menu row focus upwards.",
    function(w) w.menu:move_up() end,
  },
  {
    "<C-n>",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
})

--- completion
modes.add_binds("completion", {
  {
    "<C-p>",
    "Move the menu row focus upwards.",
    function(w) w.menu:move_up() end,
  },
  {
    "<C-n>",
    "Move the menu row focus downwards.",
    function(w) w.menu:move_down() end,
  },
})

--- Command History
modes.remap_binds("cmdhist", {
  { "<C-p", "<Up>" },
  { "<C-n", "<Down>" },
})


-- Search Engines
local engines = settings.window.search_engines
engines.ddg = "https://duckduckgo.com/?q=%s"
engines.default = engines.ddg

-- Hints
local select = require("select")
select.label_maker = function()
  local chars = interleave("arstgqwfp", "oienmyul")
  return chars
end

-- Set default downloads directory
local downloads = require("downloads")
downloads.default_dir = os.getenv("HOME") .. "/Downloads"
