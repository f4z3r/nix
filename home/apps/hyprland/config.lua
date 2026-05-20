local os = require("os")
local string = require("string")

local HOME = assert(os.getenv("HOME"))
local MONITOR_PREFIX = "@MONITOR_PREFIX@"
local MAIN_MONITOR = "@MAIN_MONITOR@"
local MAIN_MONITOR_RESOLUTION = "@RESOLUTION@"
local MAIN_MONITOR_SCALE = "@SCALE@"
local MAIN_MONITOR_WALLPAPER = HOME .. "/.local/share/wallpapers/@WALLPAPER@"

local WM_MODIFIER = "ALT"
local APP_MODIFIER = "ALT + CONTROL"

hl.on("hyprland.start", function()
  hl.exec_cmd("dunst")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("awww img " .. MAIN_MONITOR_WALLPAPER)
  hl.exec_cmd("hyprctl setcursor '@CURSOR_THEME@' 24")
  hl.exec_cmd(string.format("@LUAJIT@ %s/.local/share/scripts/toggle-mute.lua", HOME))
  hl.dispatch(hl.dsp.focus({ workspace = 4 }))
end)

hl.config({
  debug = {
    vfr = true,
    disable_logs = true,
  },
  general = {
    border_size = 2,
    gaps_in = 0,
    gaps_out = 0,
    ["col.active_border"] = "rgb(5900be)",
    layout = "dwindle",
  },
  dwindle = {
    preserve_split = true,
    force_split = 2,
    smart_split = false,
    smart_resizing = false,
  },
  decoration = {
    rounding = 3,
    shadow = {
      enabled = false,
    },
    dim_inactive = true,
    dim_strength = 0.3,
    blur = {
      enabled = false,
    },
  },
  input = {
    kb_layout = "us",
    kb_variant = "alt-intl",
    follow_mouse = 0,
    touchpad = {
      disable_while_typing = true,
      natural_scroll = false,
    },
  },
  misc = {
    focus_on_activate = true,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
  cursor = {
    inactive_timeout = 5,
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

hl.monitor({
  output = MAIN_MONITOR,
  mode = MAIN_MONITOR_RESOLUTION .. "@60",
  position = "0x0",
  scale = tonumber(MAIN_MONITOR_SCALE),
})

hl.monitor({
  output = MONITOR_PREFIX .. "-1",
  mode = "highres",
  position = "auto-left",
  scale = 1,
})

hl.monitor({
  output = MONITOR_PREFIX .. "-2",
  mode = "highres",
  position = "auto-right",
  scale = 1,
})

hl.monitor({
  output = "desc:Philips Consumer Electronics Company PHL 499P9 AU02024017754",
  mode = "2560x1440",
  position = "auto-left",
  scale = 1,
})

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty -e tmux"))
hl.bind("CONTROL + RETURN", hl.dsp.workspace.toggle_special("quake"))
hl.bind("ALT + Space", hl.dsp.exec_cmd("rofi -combi-modi window,drun -show combi"))

hl.bind(WM_MODIFIER .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(WM_MODIFIER .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(WM_MODIFIER .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(WM_MODIFIER .. " + N", hl.dsp.focus({ direction = "down" }))
hl.bind(WM_MODIFIER .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(WM_MODIFIER .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(WM_MODIFIER .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(WM_MODIFIER .. " + SHIFT + N", hl.dsp.window.move({ direction = "down" }))
hl.bind(WM_MODIFIER .. " + SHIFT + Y", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(WM_MODIFIER .. " + SHIFT + X", hl.dsp.window.close())

hl.bind(WM_MODIFIER .. " + Tab", hl.dsp.focus({ workspace = "previous_per_monitor" }))
hl.bind(WM_MODIFIER .. " + A", hl.dsp.focus({ workspace = 1 }))
hl.bind(WM_MODIFIER .. " + R", hl.dsp.focus({ workspace = 2 }))
hl.bind(WM_MODIFIER .. " + S", hl.dsp.focus({ workspace = 3 }))
hl.bind(WM_MODIFIER .. " + T", hl.dsp.focus({ workspace = 4 }))
hl.bind(WM_MODIFIER .. " + G", hl.dsp.focus({ workspace = 5 }))
hl.bind(WM_MODIFIER .. " + Q", hl.dsp.focus({ workspace = 6 }))
hl.bind(WM_MODIFIER .. " + W", hl.dsp.focus({ workspace = 7 }))
hl.bind(WM_MODIFIER .. " + F", hl.dsp.focus({ workspace = 8 }))
hl.bind(WM_MODIFIER .. " + P", hl.dsp.focus({ workspace = 9 }))
hl.bind(WM_MODIFIER .. " + B", hl.dsp.focus({ workspace = 0 }))
hl.bind(WM_MODIFIER .. " + SHIFT + Tab", hl.dsp.window.move({ workspace = "previous_per_monitor" }))
hl.bind(WM_MODIFIER .. " + SHIFT + A", hl.dsp.window.move({ workspace = 1 }))
hl.bind(WM_MODIFIER .. " + SHIFT + R", hl.dsp.window.move({ workspace = 2 }))
hl.bind(WM_MODIFIER .. " + SHIFT + S", hl.dsp.window.move({ workspace = 3 }))
hl.bind(WM_MODIFIER .. " + SHIFT + T", hl.dsp.window.move({ workspace = 4 }))
hl.bind(WM_MODIFIER .. " + SHIFT + G", hl.dsp.window.move({ workspace = 5 }))
hl.bind(WM_MODIFIER .. " + SHIFT + Q", hl.dsp.window.move({ workspace = 6 }))
hl.bind(WM_MODIFIER .. " + SHIFT + W", hl.dsp.window.move({ workspace = 7 }))
hl.bind(WM_MODIFIER .. " + SHIFT + F", hl.dsp.window.move({ workspace = 8 }))
hl.bind(WM_MODIFIER .. " + SHIFT + P", hl.dsp.window.move({ workspace = 9 }))
hl.bind(WM_MODIFIER .. " + SHIFT + B", hl.dsp.window.move({ workspace = 0 }))

hl.bind(APP_MODIFIER .. " + X", hl.dsp.exec_cmd("rofi -show p -modi p:@ROFI_POWER_MENU@"))
hl.bind(APP_MODIFIER .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(APP_MODIFIER .. " + O", hl.dsp.exec_cmd("sofa"))
hl.bind(
  APP_MODIFIER .. " + W",
  hl.dsp.exec_cmd(string.format("@LUAJIT@ %s/.local/share/scripts/fuzzy-bookmarks.lua", HOME))
)
hl.bind(APP_MODIFIER .. " + R", hl.dsp.exec_cmd(string.format("bash %s/.local/share/scripts/screen-record.sh", HOME)))
hl.bind(
  APP_MODIFIER .. " + P",
  hl.dsp.exec_cmd(
    "gopass ls --flat | rofi -dmenu -p Gopass | xargs --no-run-if-empty gopass show -o | head -n 1 | wl-copy -t text/sensitive"
  )
)
hl.bind(
  APP_MODIFIER .. " + N",
  hl.dsp.exec_cmd(string.format("@LUAJIT@ %s/.local/share/scripts/pomodoro.lua toggle", HOME))
)
hl.bind(
  APP_MODIFIER .. " + M",
  hl.dsp.exec_cmd(string.format("@LUAJIT@ %s/.local/share/scripts/toggle-mute.lua", HOME))
)

hl.bind("Print", hl.dsp.exec_cmd(string.format("bash %s/.local/share/scripts/screenshot.sh", HOME)))

hl.bind(WM_MODIFIER .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(WM_MODIFIER .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd(string.format("@LUAJIT@ %s/.local/share/scripts/toggle-mute.lua", HOME)),
  { locked = true }
)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc toggle"), { locked = true })

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl -c 'backlight' -d '*backlight*' s 5%-"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl -c 'backlight' -d '*backlight*' s +5%"),
  { locked = true, repeating = true }
)
hl.bind(WM_MODIFIER .. " + Z", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
  hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("N", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)
hl.bind(WM_MODIFIER .. " + E", hl.dsp.submap("split"))
hl.define_submap("split", "reset", function()
  hl.bind("L", hl.dsp.layout("preselect r"))
  hl.bind("H", hl.dsp.layout("preselect l"))
  hl.bind("K", hl.dsp.layout("preselect u"))
  hl.bind("N", hl.dsp.layout("preselect d"))
  hl.bind("right", hl.dsp.layout("preselect r"))
  hl.bind("left", hl.dsp.layout("preselect l"))
  hl.bind("up", hl.dsp.layout("preselect u"))
  hl.bind("down", hl.dsp.layout("preselect d"))
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.window_rule({
  name = "pinentry animation",
  match = { class = "Pinentry" },
  animation = "popin",
  float = true,
  center = true,
})
hl.window_rule({
  name = "quake terminal",
  match = { title = "quake" },
  animation = "popin",
  size = { "(monitor_w*0.7)", "(monitor_h*0.7)" },
  float = true,
  center = true,
  dim_around = true,
})
hl.window_rule({
  name = "brave popups",
  match = { class = "^brave$" },
  animation = "popin",
  size = { "(monitor_w*0.7)", "(monitor_h*0.7)" },
  float = true,
  center = true,
})
hl.window_rule({
  name = "google meet",
  match = { class = "^google-chrome$", title = "^Meet .*" },
  size = { "(monitor_w*0.15)", "(monitor_h*0.95)" },
  float = true,
  pin = true,
  content = "video",
  no_anim = true,
  center = true,
})
hl.window_rule({
  name = "video content youtube",
  match = { class = "^brave-browser$", title = ".*YouTube.*" },
  no_dim = true,
  idle_inhibit = "focus",
})
hl.window_rule({
  name = "video content netflix",
  match = { class = "^brave-browser$", title = ".*Netflix.*" },
  no_dim = true,
  idle_inhibit = "focus",
})

hl.layer_rule({
  name = "rofi popin",
  match = { namespace = "rofi" },
  animation = "popin",
  dim_around = true,
})
hl.layer_rule({
  name = "no anim on screen selection",
  match = { namespace = "selection" },
  no_anim = true,
})

hl.workspace_rule({ workspace = "r[1-5]", monitor = MAIN_MONITOR })
-- TODO: f4z3r - update to check if device connected
hl.workspace_rule({ workspace = "r[6-10]", monitor = MONITOR_PREFIX .. "-1" })
hl.workspace_rule({
  workspace = "special:quake",
  on_created_empty = "[ float on; size (monitor_w*0.7) (monitor_h*0.7); center on ] ghostty --title=quake --class=quake -e tmux new -s quake",
})

hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({ leaf = "workspaces", enabled = true, bezier = "easeOutExpo", speed = 2, style = "fade" })
hl.animation({ leaf = "windowsIn", enabled = true, bezier = "easeOutExpo", speed = 2, style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, bezier = "easeOutExpo", speed = 2, style = "popin" })
hl.animation({ leaf = "layers", enabled = true, bezier = "easeOutExpo", speed = 1, style = "popin" })
