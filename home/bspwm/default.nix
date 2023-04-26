{ pkgs, ... }:

{
  xsession = {
    windowManager.bspwm = {
      enable = true;
      startupPrograms = [
        "feh --bg-scale ~/.config/bspwm/wallpaper.png"
      ];
      monitors = {
        "eDP-1" = [
          "I"
          "II"
          "III"
          "IV"
          "V"
        ];
      };
      settings = {
        border_width = 3;
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
    ".config/bspwm/wallpaper.png" = {
      source = ./wallpaper.png;
    };
  };
}
