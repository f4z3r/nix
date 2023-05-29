{ pkgs, polybar_dpi, ... }:

{
  services = {
    polybar = {
      enable = true;
      script = "${pkgs.polybar}/bin/polybar";
      extraConfig = ''
        [colors]
        background = #282A2E
        background-alt = #373B41
        foreground = #C5C8C6
        primary = #F0C674
        secondary = #8ABEB7
        alert = #CC241D
        disabled = #707880

        [global/wm]
        margin-top = 0

        [base]
        width = 100%
        height = 24pt
        radius = 5

        dpi = ${toString(polybar_dpi)}

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

        modules-left = xworkspaces

        cursor-click = pointer
        cursor-scroll = ns-resize
        enable-ipc = false
        wm-restack = bspwm

        [bar/main]
        inherit = base
        monitor = eDP-1
        modules-right = pomo backlight red alsa filesystem memory cpu wlan vpn bat date

        [bar/e1]
        inherit = base
        monitor = DP-1
        modules-right = backlight red alsa filesystem memory cpu wlan vpn bat date

        [bar/e2]
        inherit = base
        monitor = DP-2
        modules-right = backlight red alsa filesystem memory cpu wlan vpn bat date

        [bar/e3]
        inherit = base
        monitor = DP-2
        modules-right = backlight red alsa filesystem memory cpu wlan vpn bat date

        [module/xworkspaces]
        type = internal/xworkspaces

        label-active = 
        label-active-background = ''${colors.background-alt}
        label-active-underline= ''${colors.primary}
        label-active-padding = 1

        label-occupied = 
        label-occupied-padding = 1

        label-urgent = 
        label-urgent-background = ''${colors.alert}
        label-urgent-padding = 1

        label-empty = 
        label-empty-foreground = ''${colors.disabled}
        label-empty-padding = 1

        [module/pomo]
        type = custom/script
        exec = ${pkgs.uair}/bin/uair
        tail = true
        label = %{F#F0C674}PO%{F-} %output%

        [module/backlight]
        type = internal/backlight
        card = intel_backlight
        use-actual-brightness = true
        format = <label>
        label = %{F#F0C674}BL%{F-} %percentage%%

        [module/red]
        type = custom/script
        exec = ${pkgs.bash}/bin/bash ~/.local/bin/redshift.sh
        tail = false
        label = %{F#F0C674}RS%{F-} %output%
        interval = 120

        [module/alsa]
        type = custom/script
        exec = ${pkgs.bash}/bin/bash ~/.local/bin/volume.sh
        tail = false
        label = %{F#F0C674}VOL%{F-} %output%
        interval = 5


        [module/filesystem]
        type = internal/fs
        interval = 25

        mount-0 = /

        label-mounted = %{F#F0C674}%mountpoint%%{F-} %percentage_used%%

        label-unmounted = %mountpoint% not mounted
        label-unmounted-foreground = ''${colors.disabled}

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
        label-disconnected = %{F#F0C674}%ifname%%{F#707880} disconnected

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
        label-connected = %{F#F0C674}%ifname%%{F-} %essid% %local_ip% %{F#F0C674}UP%{F-} %upspeed% %{F#F0C674}DN%{F-} %downspeed%

        [module/vpn]
        type = custom/script
        exec-if = systemctl is-active openvpn-*
        exec = ${pkgs.luajit}/bin/luajit ~/.local/bin/vpn.lua
        tail = false
        label = %{F#F0C674}VPN%{F-} %output%
        interval = 60

        [module/bat]
        type = internal/battery
        full-at = 89
        low-at = 20
        battery = BAT0
        poll-interval = 20

        label-charging = %{F#458588}BAT%{F-} %percentage_raw%%
        label-discharging = %{F#F0C674}BAT%{F-} %percentage_raw%%
        label-full = %{F#98971A}BAT%{F-} %percentage_raw%%
        label-low = %{F#CC241D}BAT%{F-} %percentage_raw%%

        [module/date]
        type = internal/date
        interval = 1

        date = %H:%M
        date-alt = %Y-%m-%d %H:%M:%S

        label = %date%
        label-foreground = ''${colors.primary}

        [settings]
        screenchange-reload = true
        pseudo-transparency = true

        ; vim:ft=dosini
      '';
    };
  };

  home.file = {
    ".local/bin/redshift.sh" = {
      source = ./scripts/redshift.sh;
    };
    ".local/bin/volume.sh" = {
      source = ./scripts/volume.sh;
    };
    ".local/bin/vpn.lua" = {
      source = ./scripts/vpn.lua;
    };
    ".config/uair/uair.toml" = {
      source = ./uair.toml;
    };
  };
}
# vim:ft=nix
