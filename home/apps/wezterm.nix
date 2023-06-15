{ pkgs, theme, font_size, ... }:

let
  config = ''
    local wezterm = require 'wezterm'

    local config = {}

    if wezterm.config_builder then
    config = wezterm.config_builder()
    end

    config.audible_bell = "Disabled"

    config.color_scheme = 'THEME'
    config.colors = {
      cursor_fg = "${if theme == "dark" then "#282828" else "#fbf1c7"}",
    }

    config.hide_tab_bar_if_only_one_tab = true

    config.warn_about_missing_glyphs = false
    config.font = wezterm.font('FiraCode Nerd Font Mono', {weight = 'DemiBold', stretch = 'Expanded'})
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
    extraConfig = builtins.replaceStrings [ "THEME" ] [
      (if theme == "dark" then "Gruvbox Material (Gogh)" else "Gruvbox (Gogh)")
    ] "${config}";
  };
}
