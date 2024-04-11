{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme = "improved";
    extraConfig = {
      kb-cancel = "Control+y";
    };
  };

  home.file = {
    ".local/share/rofi/themes/improved.rasi" = {
      source = ./themes/improved.rasi;
    };
    ".local/share/rofi/themes/shared/colors.rasi" = {
      source = ./themes/shared/colors.rasi;
    };
    ".local/share/rofi/themes/shared/fonts.rasi" = {
      source = ./themes/shared/fonts.rasi;
    };
  };
}
