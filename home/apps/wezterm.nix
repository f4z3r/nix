{ pkgs, theme, font_size, ... }:

let
  config = ''
    local wezterm = require 'wezterm'

    local config = {}

    if wezterm.config_builder then
    config = wezterm.config_builder()
    end

    config.audible_bell = "Disabled"

    config.color_scheme = "${if theme == "dark" then "Gruvbox Material (Gogh)" else "Gruvbox (Gogh)"}"
    config.colors = {
      cursor_fg = "${if theme == "dark" then "#282828" else "#fbf1c7"}",
      brights = {
        "${if theme == "dark" then "#928374" else "#928374"}",  -- Bright Black
        "${if theme == "dark" then "#FB4934" else "#9D0006"}",  -- Bright Red (Command error)
        "${if theme == "dark" then "#B8BB26" else "#79740E"}",  -- Bright Green (Exec)
        "${if theme == "dark" then "#FABD2F" else "#B57614"}",  -- Bright Yellow
        "${if theme == "dark" then "#83A598" else "#076678"}",  -- Bright Blue (Folder)
        "${if theme == "dark" then "#D3869B" else "#8F3F71"}",  -- Bright Magenta
        "${if theme == "dark" then "#8EC07C" else "#427B58"}",  -- Bright Cyan
        "${if theme == "dark" then "#EBDBB2" else "#3C3836"}",  -- Bright White
      }
    }

    config.hide_tab_bar_if_only_one_tab = true

    config.warn_about_missing_glyphs = false
    config.font = wezterm.font('FiraCode Nerd Font Mono', {weight = 'DemiBold'})
    config.font_size = ${toString font_size}

    config.adjust_window_size_when_changing_font_size = false

    config.disable_default_key_bindings = true
    config.keys = {
      { key = 'UpArrow', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
      { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
      { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
      { key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo 'Clipboard' },
    }

    config.window_padding = {
      left = '0.5cell',
      right = 0,
      top = 0,
      bottom = 0
    }

    return config
  '';

in {
  programs.wezterm = {
    enable = true;
    extraConfig = config;
  };
}
