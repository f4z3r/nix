{
  pkgs,
  pkgs-stable,
  lib,
  stdenv,
  pkgs-custom,
  scale,
  username,
  resolution,
  main_monitor,
  monitor_prefix,
  colors,
  ...
}:
assert lib.asserts.assertOneOf "theme" colors.theme ["dark" "light"]; let
  gtkTheme =
    if colors.theme == "dark"
    then "Materia-dark"
    else "Materia-light";
  iconTheme =
    if colors.theme == "dark"
    then "Papirus-Dark"
    else "Papirus-Light";
  cursorTheme =
    if colors.theme == "dark"
    then "Capitaine Cursors (Gruvbox) - White"
    else "Capitaine Cursors (Gruvbox)";
  python = import ./langs/python.nix {inherit pkgs;};
in {
  imports = [
    (import ./langs/lua.nix {inherit pkgs lib username;})
    (import ./apps {
      inherit
        pkgs
        pkgs-stable
        lib
        stdenv
        pkgs-custom
        scale
        username
        resolution
        main_monitor
        monitor_prefix
        colors
        ;
    })
  ];

  programs = {
    home-manager.enable = true;

    mpv.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
      colors = {
        bg = colors.background;
        fg = colors.foreground;
        "bg+" = colors.background;
        "fg+" = colors.purple;
        hl = colors.aqua;
        "hl+" = colors.purple;
        info = colors.orange;
        marker = colors.green;
        prompt = colors.red;
        spinner = colors.orange;
        pointer = colors.purple;
        header = colors.blue;
      };
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [
          "-p80%,60%"
        ];
      };
    };

    # used for presenterm stuff
    kitty.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tealdeer = {
      enable = true;
      settings = {updates = {auto_update = false;};};
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        vim_keys = true;
        clock_format = "%H";
      };
    };

    eza = {
      enable = true;
      icons = "auto";
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

    batsignal = {
      enable = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      # GUI programs
      gimp
      pkgs-stable.brave
      onlyoffice-desktopeditors
      vial
      pkgs-stable.fava

      # utils
      beancount
      buildah
      devbox
      dogdns
      erdtree
      fd
      fend
      gcc
      gnumake
      imagemagick
      imv
      jq
      just
      miniserve
      mupdf
      openssl
      ouch
      presenterm
      procs
      rclone
      ripgrep
      rsync
      silver-searcher
      tree
      typst
      vhs
      watchexec
      xcp
      yq-go
      zip

      # stuff not used often, installed via nix-shell
      #tokei
      #jless
      #pastel

      # tunnel
      firefox
      gopass

      # stuff used for GTK theming
      gtk-engine-murrine

      # stuff used in the background
      alsa-utils
      bc
      ffmpeg
      file
      grim
      mpc
      satty
      slurp
      step-cli
      swww
      wl-clipboard
      wl-screenrec
      yt-dlp

      # programming
      delve
      dive
      python
      go
      kubectl
      kubectx
      kubernetes-helm
      pkgs-stable.dprint
      ruff
      rustup
    ];

    file = {
      ".config/ruff/pyproject.toml" = {source = ./files/ruff.toml;};
      "revive.toml" = {source = ./files/revive.toml;};
      ".local/bin/mip" = {
        source = ./scripts/mip;
        executable = true;
      };
      ".local/bin/gcl" = {
        source = ./scripts/gcl;
        executable = true;
      };
      ".local/bin/play-notification.sh" = {
        text = ''
          #!/bin/sh

          ffplay -v 0 -nodisp -autoexit /home/${username}/.local/share/sounds/notification.mp3
        '';
        executable = true;
      };
      ".local/share/sounds/" = {
        source = ./../assets/sounds;
        recursive = true;
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
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
