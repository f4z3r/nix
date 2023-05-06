{ pkgs, ... }:

{
  xsession = {
    windowManager.bspwm = {
      enable = true;
      startupPrograms = [
        "${pkgs.feh}/bin/feh --bg-fill ~/.config/bspwm/wallpaper.jpeg"
        "${pkgs.polybar}/bin/polybar main"
      ];
      monitors = {
        "eDP-1" = [
          "I"
          "II"
          "III"
          "IV"
          "V"
        ];
        "DP-1" = [
          "VI"
          "VII"
          "VIII"
          "IX"
          "X"
        ];
        "DP-2" = [
          "XI"
          "XII"
          "XIII"
          "XIV"
          "XV"
        ];
        "DP-3" = [
          "XVI"
          "XVII"
          "XVIII"
          "XIX"
          "XX"
        ];
      };
      rules = {
        "quake" = {
          state = "floating";
          center = true;
          rectangle = "2560x1600+0+0";
        };
      };
      settings = {
        border_width = 5;
        normal_border_color = "";
        active_border_color = "\#145f9d";
        focused_border_color = "\#145f9d";

        window_gap = 12;

        click_to_focus = true;
        focus_follows_pointer = false;

        split_ratio = 0.5;

        borderless_monocle = true;
        gapless_monocle = true;

        remove_unplugged_monitors = true;
        remove_disabled_monitors = true;
        merge_overlapping_monitors = true;
      };
    };
  };

  home.file = {
    ".config/bspwm/wallpaper.jpeg" = {
      source = ./wallpaper.jpeg;
    };
  };
}
