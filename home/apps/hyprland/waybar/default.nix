{
  pkgs,
  colors,
  ...
}: let
  yellow =
    if colors.theme == "dark"
    then "#d8a657"
    else "#b47109";
  luajit = import ../../../langs/luajit.nix {inherit pkgs;};
in {
  programs = {
    waybar = {
      enable = true;
      style =
        if colors.theme == "light"
        then
          builtins.replaceStrings
          ["#282828" "#d4be98" "#635850"]
          ["#fbf1c7" "#654735" "#ebdbb2"]
          (builtins.readFile ./style.css)
        else (builtins.readFile ./style.css);
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
            "backlight"
            "idle_inhibitor"
            "pulseaudio"
            "custom/pomodoro"
          ];
          modules-right = ["cpu" "memory" "disk" "network" "custom/vpn" "battery" "clock"];
          "hyprland/workspaces" = {
            format = "<sub>{icon}</sub>{windows}";
            format-window-separator = "|";
            format-icons = {
              # "1" = "";
              # "2" = "";
              # "3" = "󰈹";
              default = "󰺕";
              empty = "";
              presistent = "󰺕";
              special = "";
              urgent = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
            window-rewrite-default = "󰺕";
            window-rewrite = {
              "class<com.mitchellh.ghostty>" = "󰊠";
              "class<google-chrome>" = "";
              "class<brave-browser>" = "󰴳";
              "class<firefox>" = "󰈹";
            };
          };
          backlight = {
            format = ''<span color="${yellow}">BL</span> {percent}%'';
          };
          idle_inhibitor = {
            format = ''<span color="${yellow}">IDL</span> {icon}'';
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          pulseaudio = {
            on-click = ''${luajit}/bin/luajit ~/.local/share/scripts/toggle-mute.lua'';
            format = ''<span color="${yellow}">VOL</span> {volume}% {icon} {format_source}'';
            format-bluetooth = ''<span color="${yellow}">VOL</span> 󰂯 {volume}% {icon} {format_source}'';
            format-bluetooth-muted = ''<span color="${yellow}">VOL</span> 󰂯 {volume}% {icon}  {format_source}'';
            format-muted = ''<span color="${yellow}">VOL</span> {volume}%  {format_source}'';
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
          "custom/pomodoro" = {
            exec = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua";
            return-type = "json";
            interval = 1;
            format = ''<span color="${yellow}">POM</span> {}'';
            on-click = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua toggle";
            on-click-right = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua skip";
            on-click-middle = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua reset";
            on-scroll-up = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua plus";
            on-scroll-down = "${luajit}/bin/luajit ~/.local/share/scripts/pomodoro.lua minus";
          };
          cpu = {
            format = ''<span color="${yellow}">CPU</span> {usage}%'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = ''<span color="${yellow}">MEM</span> {used:0.1f}/{total:0.1f}Gi'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = ''<span color="${yellow}">SSD</span> {percentage_used}%'';
            unit = "GiB";
          };
          network = {
            interface = "wlp0s20f3";
            interval = 3;
            format = ''<span color="${yellow}">NET</span> {ifname}'';
            format-wifi = ''<span color="${yellow}">NET</span> <span color="#d3869b">{essid}</span> 󰖩 ({signalStrength}%) <span color="${yellow}">UP</span> {bandwidthUpBytes} <span color="${yellow}">DN</span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="${yellow}">NET</span> <span color="#d3869b">{ipaddr}/{cidr}</span> <span color="${yellow}">UP</span> {bandwidthUpBytes} <span color="${yellow}">DN</span> {bandwidthDownBytes}'';
            format-disconnected = ''<span color="${yellow}">NET</span> <span color="#7c6f64">disconnected</span>'';
          };
          "custom/vpn" = {
            exec = "${luajit}/bin/luajit ~/.local/share/scripts/vpn.lua";
            exec-if = ''systemctl is-active "openvpn-*"'';
            interval = 60;
            format = ''<span color="${yellow}">VPN</span> {}'';
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = ''<span color="${yellow}">BAT</span> {capacity}%'';
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
    ".local/share/scripts/pomodoro.lua" = {
      source = ./../scripts/pomodoro.lua;
    };
  };
}
