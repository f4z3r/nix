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
  imports = [
    (import ./waybar/default.nix)
    (import ./hypridle.nix)
    (import ./hyprlock.nix)
  ];
  services.cliphist = {
    enable = true;
  };
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        settings = {
          exec-once = [
            "${pkgs.dunst}/bin/dunst"
            "wl-paste --watch cliphist store"
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
            ''$wm SHIFT, L, swapwindow, r''
            ''$wm SHIFT, H, swapwindow, l''
            ''$wm SHIFT, K, swapwindow, d''
            ''$wm SHIFT, N, swapwindow, d''

            ''$wm SHIFT, Y, fullscreen''
            ''$wm SHIFT, X, killactive''

            ''$wm, Tab, workspace, previous_per_monitor''
            ''$wm, A, workspace, 1''
            ''$wm, R, workspace, 2''
            ''$wm, S, workspace, 3''
            ''$wm, T, workspace, 4''
            ''$wm, G, workspace, 5''
            ''$wm, Q, workspace, 6''
            ''$wm, W, workspace, 7''
            ''$wm, F, workspace, 8''
            ''$wm, P, workspace, 9''
            ''$wm, B, workspace, 0''
            ''$wm SHIFT, A, movetoworkspace, 1''
            ''$wm SHIFT, R, movetoworkspace, 2''
            ''$wm SHIFT, S, movetoworkspace, 3''
            ''$wm SHIFT, T, movetoworkspace, 4''
            ''$wm SHIFT, G, movetoworkspace, 5''
            ''$wm SHIFT, Q, movetoworkspace, 6''
            ''$wm SHIFT, W, movetoworkspace, 7''
            ''$wm SHIFT, F, movetoworkspace, 8''
            ''$wm SHIFT, P, movetoworkspace, 9''
            ''$wm SHIFT, B, movetoworkspace, 0''

            '', Print, exec, ${pkgs.flameshot}/bin/flameshot gui''
          ];
          bezier = [
            ''easeOutExpo, 0.16, 1, 0.3, 1''
          ];
          animation = [
            ''workspaces, 1, 2, easeOutExpo, fade''
            ''windowsIn, 1, 2, easeOutExpo, slide''
            ''windowsOut, 1, 2, easeOutExpo, popin''
          ];
          bindle = [
            '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+''
            '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-''
          ];
          general = {
            border_size = 2;
            gaps_in = 0;
            gaps_out = 0;
            "col.active_border" = "rgb(5900be)";
            layout = "dwindle";
          };
          decoration = {
            rounding = 3;
            drop_shadow = false;
            dim_inactive = true;
            dim_strength = 0.3;
            blur = {
              enabled = false;
            };
          };
          input = {
            kb_layout = "us";
            kb_variant = "alt-intl";
            follow_mouse = 0;
            touchpad = {
              disable_while_typing = true;
              natural_scroll = true;
            };
          };
          misc = {
            vfr = true;
          };
          cursor = {
            inactive_timeout = 5;
          };
        };
        # importantPrefixes = "";
        # extraConfig = ''
        #   bind = $wm, R, submap, resize
        #   submap = resize
        #   binde = , h, resizeactive, 10 0
        #   binde = , l, resizeactive, -10 0
        #   binde = , k, resizeactive, 0 -10
        #   binde = , n, resizeactive, 0 10
        #   binde = , right, resizeactive, 10 0
        #   binde = , left, resizeactive, -10 0
        #   binde = , up, resizeactive, 0 -10
        #   binde = , down, resizeactive, 0 10
        #   bind = , escape, submap, reset
        #   submap = reset
        # '';
        systemd = {
          enable = true;
        };
        xwayland = {
          enable = true;
        };
      };
    };
  };
  services = {
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
