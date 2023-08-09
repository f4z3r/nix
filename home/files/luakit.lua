local luakit = require("luakit")
local settings = require("settings")
settings.window.home_page = "https://xkcd.com/"
settings.webview.enable_webgl = true
settings.session.always_save = true
settings.application.prefer_dark_mode = true
settings.webview.enable_webaudio = true
settings.webview.enable_java = false

-- Editor
local editor = require("editor")
editor.editor_cmd = "wezterm start nvim {file} +{line}"

-- Key bindings
local modes = require("modes")
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
    "T",
    "Enter tabmenu mode.",
    function(w) w:set_mode("tabmenu") end,
  },
  {
    "q",
    "Enter qmarklist mode.",
    function(w) w:set_mode("qmarklist") end,
  },
  {
    "H",
    "Enter tabhistory mode.",
    function(w) w:set_mode("tabhistory") end,
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
modes.add_binds("tabmenu", {{
  "n",
  "Move the menu row focus downwards.",
  function(w) w.menu:move_down() end,
}})

--- Tabhistory
modes.add_binds("tabhistory", {{
  "n",
  "Move the menu row focus downwards.",
  function(w) w.menu:move_down() end,
}})

--- Qmarklist
modes.add_binds("qmarklist", {{
  "n",
  "Move the menu row focus downwards.",
  function(w) w.menu:move_down() end,
}})

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
select.label_marker = function()
  local chars = interleave("arstgqwfpb", "oienmyulj")
  return chars
end

-- Set default downloads directory
local downloads = require("downloads")
downloads.default_dir = os.getenv("HOME") .. "/Downloads"
