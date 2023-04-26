{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    terminal = "wezterm";
    font = "FuraMono Nerd Font Mono 20";
    theme = "rounded-gray-dark";
    plugins = with pkgs; [
      #rofi-power-menu
      #rofi-systemd
      #rofi-rbw
    ];
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
