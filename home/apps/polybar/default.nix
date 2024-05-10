{
  pkgs,
  polybar_dpi,
  main_monitor,
  monitor_prefix,
  theme,
  ...
}:
  let
    colors = if theme == "dark" then
      {
        background = "#282828";
        background-alt = "#32302f";
        foreground = "#d4be98";
        primary = "#d8a657";
        secondary = "#89b482";
        tertiary = "#d3869b";
        alert = "#ea6962";
        disabled = "#7c6f64";
      }
    else
      {
        background = "#fbf1c7";
        background-alt = "#f4e8be";
        foreground = "#654735";
        primary = "#b47109";
        secondary = "#4c7a5d";
        tertiary = "#945e80";
        alert = "#c14a4a";
        disabled = "#7c6f64";
      }
    ;
  in {
  services = {
    polybar = {
      enable = true;
      script = "${pkgs.polybar}/bin/polybar";
      extraConfig = ''
        [colors]
        background = ${colors.background}
        background-alt = ${colors.background-alt}
        foreground = ${colors.foreground}
        primary = ${colors.primary}
        secondary = ${colors.secondary}
        tertiary = ${colors.tertiary}
        alert = ${colors.alert}
        disabled = ${colors.disabled}

        [global/wm]
        margin-top = 0

        [base]
        width = 100%
        height = 24pt
        radius = 5

        dpi = ${toString polybar_dpi}

        background = ''${colors.background}
        foreground = ''${colors.foreground}

        line-size = 3pt

        border-size = 0pt

        padding-left = 0
        padding-right = 1

        module-margin = 1

        separator = |
        separator-foreground = ''${colors.disabled}
        tray-position = none

        font-0 = monospace;2

        modules-left = xworkspaces backlight alsa
        modules-right = cpu memory ssd wlan vpn bat date

        cursor-click = pointer
        cursor-scroll = ns-resize
        enable-ipc = false
        wm-restack = bspwm

        [bar/main]
        inherit = base
        monitor = ${main_monitor}
        modules-left = xworkspaces backlight alsa

        [bar/e1]
        inherit = base
        monitor = ${monitor_prefix}-1

        [bar/e2]
        inherit = base
        monitor = ${monitor_prefix}-2

        [bar/e3]
        inherit = base
        monitor = ${monitor_prefix}-3

        [module/xworkspaces]
        type = internal/xworkspaces

        pin-workspaces = true

        label-active = 
        label-active-background = ''${colors.background-alt}
        label-active-underline = ''${colors.tertiary}
        label-active-padding = 1

        label-occupied = 
        label-occupied-padding = 1

        label-urgent = 
        label-urgent-background = ''${colors.alert}
        label-urgent-padding = 1

        label-empty = 
        label-empty-foreground = ''${colors.disabled}
        label-empty-padding = 1

        [module/backlight]
        type = internal/backlight
        card = intel_backlight
        use-actual-brightness = true
        format = <label>
        label = %{F${colors.primary}}BL%{F-} %percentage%%

        [module/alsa]
        type = custom/script
        exec = ${pkgs.luajit}/bin/luajit ~/.local/bin/vol.lua
        interval = 3

        [module/ssd]
        type = internal/fs
        interval = 30
        fixed-values = true
        warn-percentage = 85
        label-mounted = %{F${colors.primary}}SSD%{F-} %percentage_used%%
        label-warn = %{F${colors.alert}}SSD%{F-} %percentage_used%%

        [module/memory]
        type = internal/memory
        interval = 2
        format-prefix = "RAM "
        format-prefix-foreground = ''${colors.primary}
        label = %percentage_used:2%%

        [module/cpu]
        type = internal/cpu
        interval = 2
        format-prefix = "CPU "
        format-prefix-foreground = ''${colors.primary}
        label = %percentage:2%%

        [network-base]
        type = internal/network
        interval = 5
        speed-unit = ""
        format-connected = <label-connected>
        format-disconnected = <label-disconnected>
        label-disconnected = %{F${colors.primary}}%ifname%%{F${colors.disabled}} disconnected

        [module/wlan]
        inherit = network-base
        format-connected = <label-connected> <ramp-signal>
        ramp-signal-0 = 󰣽
        ramp-signal-1 = 󰣾
        ramp-signal-2 = 󰣴
        ramp-signal-3 = 󰣶
        ramp-signal-4 = 󰣸
        ramp-signal-5 = 󰣺
        interface-type = wireless
        interface = wlp0s20f3
        label-connected = %{F${colors.primary}}%ifname%%{F-} %{F${colors.tertiary}}%essid%%{F-} %local_ip% %{F${colors.secondary}}UP%{F-} %upspeed% %{F${colors.secondary}}DN%{F-} %downspeed%

        [module/vpn]
        type = custom/script
        exec-if = systemctl is-active openvpn-*
        exec = ${pkgs.luajit}/bin/luajit ~/.local/bin/vpn.lua
        tail = false
        label = %{F${colors.primary}}VPN%{F-} %output%
        interval = 60

        [module/bat]
        type = internal/battery
        full-at = 89
        low-at = 20
        battery = BAT0
        poll-interval = 20

        label-charging = %{F${colors.tertiary}}BAT%{F-} %percentage_raw%%
        label-discharging = %{F${colors.primary}}BAT%{F-} %percentage_raw%%
        label-full = %{F#a9b665}BAT%{F-} %percentage_raw%%
        label-low = %{F${colors.alert}}BAT%{F-} %percentage_raw%%

        [module/date]
        type = internal/date
        interval = 60

        date = %Y-%m-%d %H:%M
        date-alt = %H:%M

        label = %date%
        label-foreground = ''${colors.primary}

        [settings]
        screenchange-reload = true
        pseudo-transparency = true
      '';
    };
  };

  home.file = {
    ".local/bin/vol.lua" = {source = ./scripts/vol.lua;};
    ".local/bin/vpn.lua" = {source = ./scripts/vpn.lua;};
  };
}
# vim:ft=nix
