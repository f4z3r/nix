{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme = "rounded-gray-dark";
  };

  home.file = {
    ".local/share/rofi/themes/rounded-common.rasi" = {
      source = ./themes/rounded-common.rasi;
    };
    ".local/share/rofi/themes/rounded-gray-dark.rasi" = {
      source = ./themes/rounded-gray-dark.rasi;
    };
  };
}
