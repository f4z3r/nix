{...}: {
  programs = {
    waybar = {
      enable = true;
      style = builtins.readFile ./style.css;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 20;
          spacing = 4;
          modules-left = ["hyprland/workspaces" "backlight" "pulseaudio"];
          modules-right = ["battery"];
          "hyprland/workspaces" = {
            "format" = "{icon}";
            "format-icon" = {
              active = "";
              default = "󰺕";
              empty = "";
              persistent = "";
              special = "";
              urgent = "";
            };
            "window-rewrite" = {
              "title<.*youtube.*>" = "";
              "class<brave>" = "";
              "class<brave> title<.*github.*>" = "";
              "wezterm" = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
          };
          backlight = {
            # "device": "acpi_video1",
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
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
}
