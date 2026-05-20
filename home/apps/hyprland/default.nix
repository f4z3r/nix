{
  pkgs,
  pkgs-stable,
  username,
  main_monitor,
  monitor_prefix,
  resolution,
  scale,
  colors,
  ...
}: let
  cursorTheme =
    if colors.theme == "dark"
    then "Capitaine Cursors (Gruvbox) - White"
    else "Capitaine Cursors (Gruvbox)";
  wallpaper =
    if colors.theme == "dark"
    then "midnight-reflections-moonlit-sea.jpg"
    else "mountains-with-sky.jpg";
  luajit = import ../../langs/luajit.nix {inherit pkgs;};
in {
  imports = [
    (import ./waybar/default.nix {inherit pkgs colors;})
    (import ./hypridle.nix)
    (import ./hyprlock.nix)
  ];
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;
        configType = "lua";
        extraConfig =
          builtins.replaceStrings
          [
            "@LUAJIT@"
            "@ROFI_POWER_MENU@"
            "@WALLPAPER@"
            "@CURSOR_THEME@"
            "@RESOLUTION@"
            "@SCALE@"
            "@MAIN_MONITOR@"
            "@MONITOR_PREFIX@"
          ]
          [
            "${luajit}/bin/luajit"
            "${pkgs.rofi-power-menu}/bin/rofi-power-menu"
            "${wallpaper}"
            "${cursorTheme}"
            "${resolution}"
            "${toString scale}"
            "${main_monitor}"
            "${monitor_prefix}"
          ]
          (builtins.readFile ./config.lua);
        systemd = {
          enable = true;
        };
        xwayland = {
          enable = true;
        };
      };
    };
  };
  home.file = {
    ".local/share/scripts/fuzzy-bookmarks.lua" = {
      source = ./scripts/fuzzy-bookmarks.lua;
    };
    ".local/share/scripts/toggle-mute.lua" = {
      source = ./scripts/toggle-mute.lua;
    };
    ".local/share/wallpapers/" = {
      source = ./../../../assets/wallpapers;
      recursive = true;
    };
    ".local/share/scripts/screenshot.sh" = {
      text = ''
        ${pkgs.grim}/bin/grim \
          -g "$(${pkgs.slurp}/bin/slurp)" - \
          | ${pkgs.satty}/bin/satty \
            --filename - \
            --output-filename "/home/${username}/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
      '';
    };
    ".local/share/scripts/screen-record.sh" = {
      text = ''
        if pidof wl-screenrec; then
          pkill wl-screenrec;
        else
          ${pkgs.wl-screenrec}/bin/wl-screenrec \
            --dri-device /dev/dri/card1 \
            -g "$(${pkgs.slurp}/bin/slurp)" \
            --filename "/home/${username}/screenshots/screenrec-$(date '+%Y%m%d-%H:%M:%S').mp4";
        fi
      '';
    };
  };
}
