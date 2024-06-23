{
  pkgs,
  hostname,
  scratch_res,
  main_monitor,
  monitor_prefix,
  theme,
  ...
}: {
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name =
      if theme == "dark"
      then "Capitaine Cursors (Gruvbox) - White"
      else "Capitaine Cursors (Gruvbox)";
  };
  xsession = {
    windowManager.bspwm = {
      enable = true;
      startupPrograms = [
        "${pkgs.feh}/bin/feh --bg-fill ~/.config/bspwm/${hostname}-wallpaper.jpeg"
        "${pkgs.polybar}/bin/polybar main"
      ];
      monitors = {
        ${main_monitor} = ["I" "II" "III" "IV" "V"];
        "${monitor_prefix}-1" = ["VI" "VII" "VIII" "IX" "X"];
        "${monitor_prefix}-2" = ["XI" "XII" "XIII" "XIV" "XV"];
        "${monitor_prefix}-3" = ["XVI" "XVII" "XVIII" "XIX" "XX"];
      };
      rules = {
        "quake" = {
          state = "floating";
          center = true;
          rectangle = "${scratch_res}";
        };
      };
      settings = {
        border_width = 3;
        normal_border_color = "";
        active_border_color = "#145f9d";
        focused_border_color = "#145f9d";

        window_gap = 7;

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
    ".config/bspwm/${hostname}-wallpaper.jpeg" = {
      source = ./${hostname}-wallpaper.jpeg;
    };
  };
}
