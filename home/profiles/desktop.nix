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
  orchis = pkgs-stable.orchis-theme.override {
    tweaks = [
      "black"
      "submenu"
      "primary"
    ];
  };

  gtkTheme =
    if colors.theme == "dark"
    then "Orchis-Purple-Dark"
    else "Orchis-Purple-Light";

  iconTheme =
    if colors.theme == "dark"
    then "Papirus-Dark"
    else "Papirus-Light";

  cursorTheme =
    if colors.theme == "dark"
    then "Capitaine Cursors (Gruvbox) - White"
    else "Capitaine Cursors (Gruvbox)";
in {
  imports = [
    (import ../apps/hyprland {inherit pkgs pkgs-stable username main_monitor monitor_prefix resolution scale colors;})
    (import ../apps/rofi {inherit pkgs colors;})
    (import ../apps/mpd {inherit pkgs username;})
  ];

  programs = {
    mpv.enable = true;
    kitty.enable = true;

    ghostty = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      installBatSyntax = true;
      installVimSyntax = true;
      clearDefaultKeybinds = true;
      settings = {
        font-family = "MonaspiceNe Nerd Font Mono";
        font-variation = "wght=450";
        font-family-italic = "MonaspiceAr Nerd Font Mono";
        font-variation-italic = "wght=450";
        font-family-bold-italic = "MonaspiceAr Nerd Font Mono";
        font-feature = [
          "+calt"
          "+ss01"
          "+ss02"
          "+ss03"
          "+ss04"
          "+ss05"
          "+ss06"
          "+ss07"
          "+ss08"
          "+ss09"
          "+ss10"
          "+liga"
        ];
        cursor-invert-fg-bg = true;
        cursor-style-blink = false;
        cursor-style = "block";
        window-decoration = "none";
        link-url = true;
        theme =
          if colors.theme == "dark"
          then "Gruvbox Dark"
          else "Gruvbox Light";
        keybind = [
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+down=decrease_font_size:1"
          "ctrl+up=increase_font_size:1"
          "ctrl+equal=reset_font_size"
          "ctrl+period=reload_config"
        ];
        config-file = "?/home/${username}/.config/ghostty/overrides";
      };
    };
  };

  services = {
    dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
        size = "64x64";
      };
      settings = {
        global = {
          follow = "mouse";
        };

        fullscreen = {
          fullscreen = "show";
        };

        urgency_low = {
          frame_color = "#1D918B";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 2;
        };

        urgency_normal = {
          frame_color = "#D16BB7";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 5;
        };

        urgency_critical = {
          frame_color = "#FC2929";
          foreground = "#FFFF00";
          background = "#18191E";
          timeout = 0;
        };

        alert = {
          summary = "*";
          script = "/home/${username}/.local/bin/play-notification.sh";
        };
      };
    };

    gammastep = {
      enable = true;
      dawnTime = "06:00";
      duskTime = "19:00";
    };

    batsignal.enable = true;
  };

  home.packages = with pkgs; [
    gimp
    pkgs-stable.brave
    onlyoffice-desktopeditors
    vial
    pkgs-stable.fava

    imv
    mupdf
    firefox

    alsa-utils
    awww
    ffmpeg
    grim
    imagemagick
    miniserve
    mpc
    satty
    slurp
    vhs
    wl-clipboard
    wl-screenrec
    yt-dlp

    # nvim backends
    beancount
    beancount-language-server
    buildah
    dive
    kcl
    kcl-language-server
    lldb
    rustup
    tinymist
    typst
    typstyle
  ];

  gtk = {
    enable = true;
    colorScheme = colors.theme;

    theme = {
      package = orchis;
      name = gtkTheme;
    };

    gtk4.theme = {
      package = orchis;
      name = gtkTheme;
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = iconTheme;
    };

    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = cursorTheme;
      size = 32;
    };
  };

  xdg.desktopEntries = {
    imv = {
      name = "imv";
      genericName = "Image Viewer";
      exec = "imv %F";
      terminal = false;
      categories = ["Graphics" "Viewer"];
      mimeType = [
        "image/bmp"
        "image/gif"
        "image/jpeg"
        "image/jpg"
        "image/pjpeg"
        "image/png"
        "image/tiff"
        "image/x-bmp"
        "image/x-pcx"
        "image/x-png"
        "image/x-portable-anymap"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-pixmap"
        "image/x-tga"
        "image/x-xbitmap"
      ];
    };
  };
}
