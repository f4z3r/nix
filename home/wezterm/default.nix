{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = 'Gruvbox Material (Gogh)'
      config.hide_tab_bar_if_only_one_tab = true
      config.warn_about_missing_glyphs = false
      config.font = wezterm.font('FuraMono Nerd Font Mono', {weight = 'Medium'})
      config.font_size = 17
      config.keys = {
        { key = 'UpArrow', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
        { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
      }

      return config
    '';
  };
}
