{pkgs, ...}: {
  programs = {
    waybar = {
      enable = true;
      style = builtins.readFile ./style.css;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          spacing = 4;
          modules-left = ["hyprland/workspaces" "backlight" "idle_inhibitor" "pulseaudio"];
          modules-right = ["cpu" "memory" "disk" "network" "custom/vpn" "battery" "clock"];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "󰈹";
              default = "󰺕";
              empty = "";
              presistent = "󰺕";
              special = "";
              urgent = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
          };
          backlight = {
            format = ''<span color="#d8a657">BL</span> {percent}%'';
          };
          idle_inhibitor = {
            format = ''<span color="#d8a657">IDL</span> {icon}'';
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          pulseaudio = {
            format = ''<span color="#d8a657">VOL</span> {volume}% {icon} {format_source}'';
            format-bluetooth = ''<span color="#d8a657">VOL</span> 󰂯 {volume}% {icon} {format_source}'';
            format-bluetooth-muted = ''<span color="#d8a657">VOL</span> 󰂯 {volume}% {icon}  {format_source}'';
            format-muted = ''<span color="#d8a657">VOL</span> {volume}%  {format_source}'';
            format-source = "{volume}% 󰍬";
            format-source-muted = "󰍭";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
          };
          cpu = {
            format = ''<span color="#d8a657">CPU</span> {usage}%'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = ''<span color="#d8a657">MEM</span> {used:0.1f}/{total:0.1f}Gi'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = ''<span color="#d8a657">SSD</span> {percentage_used}%'';
            unit = "GiB";
          };
          network = {
            interface = "wlp0s20f3";
            interval = 3;
            format = ''<span color="#d8a657">NET</span> {ifname}'';
            format-wifi = ''<span color="#d8a657">NET</span> <span color="#d3869b">{essid}</span> 󰖩 ({signalStrength}%) <span color="#d8a657">UP</span> {bandwidthUpBytes} <span color="#d8a657">DN</span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="#d8a657">NET</span> <span color="#d3869b">{ipaddr}/{cidr}</span> <span color="#d8a657">UP</span> {bandwidthUpBytes} <span color="#d8a657">DN</span> {bandwidthDownBytes}'';
            format-disconnected = ''<span color="#d8a657">NET</span> <span color="#7c6f64">disconnected</span>'';
          };
          "custom/vpn" = {
            exec = "${pkgs.luajit}/bin/luajit ~/.local/share/scripts/vpn.lua";
            exec-if = ''systemctl is-active "openvpn-*"'';
            interval = 60;
            format = ''<span color="#d8a657">VPN</span> {}'';
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = ''<span color="#d8a657">BAT</span> {capacity}%'';
          };
          clock = {
            format = "{:%F %R}";
            interval = 60;
          };
        };
      };
      systemd.enable = true;
    };
  };
  home.file = {
    ".local/share/scripts/vpn.lua" = {
      source = ./../scripts/vpn.lua;
    };
  };
}
