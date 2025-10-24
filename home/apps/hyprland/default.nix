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
    then "~/.local/share/wallpapers/midnight-reflections-moonlit-sea.jpg"
    else "~/.local/share/wallpapers/mountains-with-sky.jpg";
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
        package = pkgs-stable.hyprland;
        settings = {
          debug = {
            disable_logs = true;
          };
          exec-once = [
            "${pkgs.dunst}/bin/dunst"
            "${pkgs.swww}/bin/swww-daemon"
            "${pkgs.swww}/bin/swww img ${wallpaper}"
            # manually launch cliphist to store only text and images, no passwords (x-kde-passwordManagerHint)
            "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.luajit}/bin/luajit ~/.local/share/scripts/cliphist-filter.lua"
            "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist -max-dedupe-search 10 -max-items 500 store"
            "${pkgs.hyprland}/bin/hyprctl setcursor '${cursorTheme}' 24"
            "${luajit}/bin/luajit /home/${username}/.local/share/scripts/toggle-mute.lua"
          ];
          env = [
            ''GTK_THEME,Materia-dark''
            ''XDG_SESSION_TYPE,wayland''
          ];
          "$general" = "SUPER";
          "$wm" = "ALT";
          "$app" = "CONTROL";
          monitor = [
            ''${main_monitor}, ${resolution}@60, 0x0,${toString scale}''
            # ''DP-1, 5120x1440@60, -1920x0, 1''
            # ''DP-2, 5120x1440@60, 1920x0, 1''
            ''${monitor_prefix}-1, highres, auto-left, 1''
            ''${monitor_prefix}-2, highres, auto-right, 1''
            # monitor=desc:Chimei Innolux Corporation 0x150C,preferred,auto,1.5
          ];
          bind = [
            ''$general, RETURN, exec, ghostty -e ${pkgs.tmux}/bin/tmux''

            ''$app, RETURN, togglespecialworkspace, quake''

            ''$wm, Space, exec, ${pkgs.rofi}/bin/rofi -combi-modi window,drun -show combi''

            ''$wm, L, movefocus, r''
            ''$wm, H, movefocus, l''
            ''$wm, K, movefocus, u''
            ''$wm, N, movefocus, d''
            ''$wm SHIFT, L, movewindoworgroup, r''
            ''$wm SHIFT, H, movewindoworgroup, l''
            ''$wm SHIFT, K, movewindoworgroup, u''
            ''$wm SHIFT, N, movewindoworgroup, d''

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
            ''$wm SHIFT, Tab, movetoworkspace, special:quake''
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

            ''$wm&$app, x, exec, ${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu''
            ''$wm&$app, l, exec, loginctl lock-session''
            ''$wm&$app, o, exec, /etc/profiles/per-user/${username}/bin/sofa''
            ''$wm&$app, w, exec, ${luajit}/bin/luajit /home/${username}/.local/share/scripts/fuzzy-bookmarks.lua''
            ''$wm&$app, r, exec, bash /home/${username}/.local/share/scripts/screen-record.sh''
            ''$wm&$app, c, exec, ${pkgs.rofi}/bin/rofi -modi clipboard:/home/${username}/.local/bin/cliphist-rofi-img.sh -show clipboard -show-icons''
            ''$wm&$app, p, exec, ${pkgs.gopass}/bin/gopass ls --flat | ${pkgs.rofi}/bin/rofi -dmenu -p Gopass | xargs --no-run-if-empty ${pkgs.gopass}/bin/gopass show -o | head -n 1 | ${pkgs.wl-clipboard}/bin/wl-copy -t text/sensitive''

            '', Print, exec, bash /home/${username}/.local/share/scripts/screenshot.sh''
          ];
          bindm = [
            ''$wm, mouse:272, movewindow''
            ''$wm, mouse:273, resizewindow''
          ];
          bindl = [
            '', XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle''
            '', XF86AudioMicMute, exec, ${luajit}/bin/luajit /home/${username}/.local/share/scripts/toggle-mute.lua''
            '', XF86AudioPlay, exec, ${pkgs.mpc-cli}/bin/mpc toggle''
          ];
          bindle = [
            '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+''
            '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-''
            '', XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 5%-''
            '', XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +5%''
          ];
          bezier = [
            ''easeOutExpo, 0.16, 1, 0.3, 1''
          ];
          animation = [
            ''workspaces, 1, 2, easeOutExpo, fade''
            ''windowsIn, 1, 2, easeOutExpo, slide''
            ''windowsOut, 1, 2, easeOutExpo, popin''
            ''layers, 1, 1, easeOutExpo, popin''
          ];
          layerrule = [
            ''animation popin,rofi''
            ''dimaround,rofi''
          ];
          windowrule = [
            # ensure pinentry grabs input
            ''animation popin,class:(Pinentry)''
            ''float,class:(Pinentry)''
            ''center,class:(Pinentry)''
            # quake window sizing
            ''dimaround,title:(quake)''
            ''float,title:(quake)''
            ''center,title:(quake)''
            ''size 70% 70%,title:(quake)''
            ''animation popin,title:(quake)''
            # make brave popups appear centrally floating
            ''float,class:^(brave)$''
            ''center,class:^(brave)$''
            ''animation popin,class:^(brave)$''
            ''size 70% 70%,class:^(brave)$''
            # make chrome meet popups appear centrally floating
            ''float,class:^(google-chrome)$,title:^(Meet –.*)''
            ''pin,class:^(google-chrome)$,title:^(Meet –.*)''
            ''content video,class:^(google-chrome)$,title:^(Meet –.*)''
            ''center,class:^(google-chrome)$,title:^(Meet –.*)''
            ''size 15% 100%,class:^(google-chrome)$,title:^(Meet –.*)''
            ''noanim,class:^(google-chrome)$,title:^(Meet –.*)''
            # set content types
            ''content video,class:^(brave-browser)$,title:(.*YouTube.*)''
            ''content video,class:^(brave-browser)$,title:(.*Netflix.*)''
            # disable idling when in full screen or playing video
            ''idleinhibit focus,fullscreen:1''
            ''idleinhibit focus,content:video''
            # do not dim windows that are playing videos even when inactive
            ''nodim,content:video''
          ];
          workspace = [
            ''r[1-5], monitor:${main_monitor}''
            ''r[6-10], monitor:${monitor_prefix}-1''
            ''r[6-10], monitor:${monitor_prefix}-2''
            # launch new terminal when opening special workspace and it is empty
            ''special:quake, on-created-empty:[ float; size 70% 70%; center ] ghostty --title=quake --class=quake -e tmux new -s quake''
          ];
          general = {
            border_size = 2;
            gaps_in = 0;
            gaps_out = 0;
            "col.active_border" = "rgb(5900be)";
            layout = "dwindle";
          };
          dwindle = {
            preserve_split = true;
            force_split = 2;
            smart_split = false;
            smart_resizing = false;
          };
          decoration = {
            rounding = 3;
            shadow = {
              enabled = false;
            };
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
              natural_scroll = false;
            };
          };
          misc = {
            vfr = true;
            focus_on_activate = true;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
          cursor = {
            inactive_timeout = 5;
          };
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
        };
        # importantPrefixes = "";
        extraConfig = ''
          bindp=$wm&$app, z, submap, resize
          submap=resize
          binde=, h, resizeactive, 10 0
          binde=, l, resizeactive, -10 0
          binde=, k, resizeactive, 0 -10
          binde=, n, resizeactive, 0 10
          binde=, right, resizeactive, 10 0
          binde=, left, resizeactive, -10 0
          binde=, up, resizeactive, 0 -10
          binde=, down, resizeactive, 0 10
          bind=, escape, submap, reset
          bind=, catchall, submap, reset
          submap=reset
          bindp=$wm&$app, s, submap, split
          submap=split
          bind=, h, layoutmsg, preselect r
          bind=, h, submap, reset
          bind=, l, layoutmsg, preselect l
          bind=, l, submap, reset
          bind=, k, layoutmsg, preselect u
          bind=, k, submap, reset
          bind=, n, layoutmsg, preselect d
          bind=, n, submap, reset
          bind=, right, layoutmsg, preselect l
          bind=, right, submap, reset
          bind=, left, layoutmsg, preselect l
          bind=, left, submap, reset
          bind=, up, layoutmsg, preselect u
          bind=, up, submap, reset
          bind=, down, layoutmsg, preselect d
          bind=, down, submap, reset
          bind=, escape, submap, reset
          bind=, h, submap, reset
          bind=, catchall, submap, reset
          submap=reset
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
  home.file = {
    ".local/share/scripts/fuzzy-bookmarks.lua" = {
      source = ./scripts/fuzzy-bookmarks.lua;
    };
    ".local/share/scripts/toggle-mute.lua" = {
      source = ./scripts/toggle-mute.lua;
    };
    ".local/bin/cliphist-rofi-img.sh" = {
      source = ./scripts/cliphist-rofi-img.sh;
      executable = true;
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
    ".local/share/scripts/cliphist-filter.lua" = {
      source = ./scripts/cliphist-filter.lua;
    };
  };
}
