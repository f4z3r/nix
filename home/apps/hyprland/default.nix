{
  pkgs,
  hostname,
  username,
  scratch_res,
  main_monitor,
  monitor_prefix,
  theme,
  ...
}: {
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        settings = {
          exec-once = [
            "${pkgs.dunst}/bin/dunst"
            "${pkgs.waybar}/bin/waybar"
          ];
          env = [
            ''GTK_THEME,Materia-dark''
            ''XDG_SESSION_TYPE,wayland''
          ];
          "$general" = "SUPER";
          "$wm" = "ALT";
          "$app" = "CONTROL";
          monitor = [
            ''eDP-1, 1920x1200@60, 0x0, 1''
            # ''DP-1, 5120x1440@60, -1920x0, 1''
            # ''DP-2, 5120x1440@60, 1920x0, 1''
            ''DP-1, highres, auto-left, 1''
            ''DP-2, highres, auto-right, 1''
            # monitor=desc:Chimei Innolux Corporation 0x150C,preferred,auto,1.5
          ];
          bind = [
            ''$general, RETURN, exec, ${pkgs.wezterm}/bin/wezterm start ${pkgs.tmux}/bin/tmux''

            ''$wm, Space, exec, ${pkgs.fuzzel}/bin/fuzzel''

            ''$wm, L, movefocus, l''
            ''$wm, H, movefocus, r''
            ''$wm, K, movefocus, u''
            ''$wm, N, movefocus, d''
            ''$wm SHIFT, L, swapwindow, l''
            ''$wm SHIFT, H, swapwindow, r''
            ''$wm SHIFT, K, swapwindow, u''
            ''$wm SHIFT, N, swapwindow, d''

            ''$wm, F, fullscreen''
            ''$wm, Q, killactive''

            ''$wm, Tab, workspace, previous_per_monitor''
            ''$wm, 1, workspace, 1''
            ''$wm, 2, workspace, 2''
            ''$wm, 3, workspace, 3''
            ''$wm, 4, workspace, 4''
            ''$wm, 5, workspace, 5''
            ''$wm, 6, workspace, 6''
            ''$wm, 7, workspace, 7''
            ''$wm, 8, workspace, 8''
            ''$wm, 9, workspace, 9''
            ''$wm, 0, workspace, 0''
            ''$wm SHIFT, 1, movetoworkspace, 1''
            ''$wm SHIFT, 2, movetoworkspace, 2''
            ''$wm SHIFT, 3, movetoworkspace, 3''
            ''$wm SHIFT, 4, movetoworkspace, 4''
            ''$wm SHIFT, 5, movetoworkspace, 5''
            ''$wm SHIFT, 6, movetoworkspace, 6''
            ''$wm SHIFT, 7, movetoworkspace, 7''
            ''$wm SHIFT, 8, movetoworkspace, 8''
            ''$wm SHIFT, 9, movetoworkspace, 9''
            ''$wm SHIFT, 0, movetoworkspace, 0''

            '', Print, exec, ${pkgs.flameshot}/bin/flameshot gui''
          ];
          bindle = [
            '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+''
            '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-''
          ];
          input = {
            kb_layout = "us";
            kb_variant = "alt-intl";
            follow_mouse = 0;
            touchpad = {
              disable_while_typing = true;
              natural_scroll = true;
            };
          };
          decorations = {
            blur = {
              # enabled = true;
            };
          };
        };
        # importantPrefixes = "";
        extraConfig = ''
          bind = $wm, R, submap, resize
          submap = resize
          binde = , h, resizeactive, 10 0
          binde = , l, resizeactive, -10 0
          binde = , k, resizeactive, 0 -10
          binde = , n, resizeactive, 0 10
          binde = , right, resizeactive, 10 0
          binde = , left, resizeactive, -10 0
          binde = , up, resizeactive, 0 -10
          binde = , down, resizeactive, 0 10
          bind = , escape, submap, reset
          submap = reset
        '';
        systemd = {
          enable = true;
        };
        xwayland = {
          enable = true;
        };
      };
    };
  };
  programs = {
    hyprlock.enable = true;
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          modules-left = ["hyprland/workspaces"];
          modules-right = ["battery"];
          "hyprland/workspaces" = {
            "format" = "<sub>{icon}</sub>\n{windows}";
            "format-window-separator" = "\n";
            "window-rewrite-default" = "";
            "window-rewrite" = {
              "title<.*youtube.*>" = "";
              "class<brave>" = "";
              "class<brave> title<.*github.*>" = "";
              "wezterm" = "";
              "vim" = "󰨞";
            };
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "BAT {capacity}%";
          };
        };
      };
      systemd.enable = true;
    };
  };
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["/home/${username}/.local/share/wallpapers/${hostname}-wallpaper.jpeg"];

        wallpaper = [
          "eDP-1,/home/${username}/.local/share/wallpapers/${hostname}-wallpaper.jpeg"
        ];
      };
    };
  };
  home.file = {
    ".local/share/wallpapers/${hostname}-wallpaper.jpeg" = {
      source = ./wallpapers/${hostname}-wallpaper.jpeg;
    };
  };
}
