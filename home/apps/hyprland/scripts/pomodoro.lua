#!/usr/bin/env luajit

local math = require("math")
local os = require("os")
local string = require("string")

local date = require("date")
local json = require("rapidjson")

local TIMES = {
  POMODORO = 50 * 60,
  SHORT_BREAK = 10 * 60,
  LONG_BREAK = 20 * 60,
}

local CYCLE_LENGTH = 2

local STATUS = {
  LONG_BREAK = "long-break",
  SHORT_BREAK = "short-break",
  POMODORO = "pomodoro",
  INACTIVE = "inactive",
}

local HOME = os.getenv("HOME")
local STATE_FILE = string.format("%s/.cache/pomodoro_state.json", HOME)

local NOW = date(true):spanseconds()

local DEFAULT_STATE = {
  status = STATUS.INACTIVE,
  pomodoros = 0,
  stop = NOW + TIMES.POMODORO,
}

local function notify(title, message)
  os.execute(string.format('notify-send "%s" "%s" -u critical -t 0 -a hyprland -i nix-snowflake', title, message))
end

local function dump_state(state)
  json.dump(state, STATE_FILE)
end

local function load_state()
  local success, state = pcall(json.load, STATE_FILE)
  if not success then
    state = DEFAULT_STATE
  end
  if state.status ~= STATUS.INACTIVE and not state.paused then
    if NOW > state.stop then
      state.paused = NOW
      if state.status == STATUS.POMODORO then
        notify("Pomodoro Complete!", "Time for a break")
        state.pomodoros = state.pomodoros + 1
        if state.pomodoros % CYCLE_LENGTH == 0 then
          state.status = STATUS.LONG_BREAK
          state.stop = NOW + TIMES.LONG_BREAK
        else
          state.status = STATUS.SHORT_BREAK
          state.stop = NOW + TIMES.SHORT_BREAK
        end
      else
        notify("Break Complete!", "Time to focus")
        state.status = STATUS.POMODORO
        state.stop = NOW + TIMES.POMODORO
      end
      dump_state(state)
    end
  end
  return state
end

local function format_time(time)
  local minutes = math.floor(time / 60)
  local seconds = time % 60
  return string.format("%02d:%02d", minutes, seconds)
end

local function skip(state)
  if state.paused or state.status == STATUS.INACTIVE then
    return
  end
  state.paused = NOW
  if state.status == STATUS.POMODORO then
    state.pomodoros = state.pomodoros + 1
    if state.pomodoros % CYCLE_LENGTH == 0 then
      state.status = STATUS.LONG_BREAK
      state.stop = NOW + TIMES.LONG_BREAK
    else
      state.status = STATUS.SHORT_BREAK
      state.stop = NOW + TIMES.SHORT_BREAK
    end
  else
    state.status = STATUS.POMODORO
    state.stop = NOW + TIMES.POMODORO
  end
  dump_state(state)
end

local function reset()
  local state = DEFAULT_STATE
  dump_state(state)
  return state
end

local function toggle(state)
  if state.status == STATUS.INACTIVE then
    state.status = STATUS.POMODORO
    state.stop = NOW + TIMES.POMODORO
  elseif state.paused then
    state.stop = NOW + (state.stop - state.paused)
    state.paused = nil
  else
    state.paused = NOW
  end
  dump_state(state)
end

local function waybar_out(state)
  local text
  local tooltip

  local status = state.status
  local left = state.stop - NOW
  if state.paused then
    status = "paused"
    left = state.stop - state.paused
  end

  if state.paused then
    text = string.format("󰏤 %s", format_time(left))
    tooltip = "Paused - Pomodoros: " .. state.pomodoros
  elseif state.status == STATUS.INACTIVE then
    text = "--:--"
    tooltip = "Click to start a pomodoro"
  elseif state.status == STATUS.POMODORO then
    text = string.format("󰔛 %s", format_time(left))
    tooltip = "Focus time - Pomodoros: " .. state.pomodoros
  elseif state.status == STATUS.SHORT_BREAK then
    text = string.format("󰭹 %s", format_time(left))
    tooltip = "Short break - Pomodoros: " .. state.pomodoros
  elseif state.status == STATUS.LONG_BREAK then
    text = string.format("󰭹 %s", format_time(left))
    tooltip = "Long break - Pomodoros: " .. state.pomodoros
  end
  tooltip = tooltip .. "\nClick: Toggle | Right-click: Skip | Middle-click: Reset"

  return json.encode({
    text = text,
    tooltip = tooltip,
    class = status,
  })
end

local function main()
  local state = load_state()
  if arg[1] == "toggle" then
    toggle(state)
  elseif arg[1] == "skip" then
    skip(state)
  elseif arg[1] == "reset" then
    state = reset()
  end
  print(waybar_out(state))
end

main()
