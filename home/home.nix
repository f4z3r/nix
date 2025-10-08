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

    rbw = {
      enable = true;
      settings = {
        email = "jakobbeckmann@pm.me";
        pinentry = pkgs.pinentry-gtk2;
      };
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    feh.enable = true;
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
    packages = with pkgs; let
      python-packages = ps:
        with ps; [
          debugpy
          pip
          virtualenv
          setuptools
          python-lsp-server
          pylsp-rope
          presenterm-export
          black
        ];
      enhanced-python = pkgs.python313.withPackages python-packages;
    in [
      # GUI programs
      gimp
      brave
      helvum
      onlyoffice-bin
      vial
      inkscape-with-extensions
      fava

      # utils
      devbox
      zip
      just
      gnumake
      gcc
      openssl
      rclone
      mupdf
      ripgrep
      silver-searcher
      procs
      tree
      jq
      pkgs-stable.dprint
      rsync
      dogdns
      fend
      ouch
      fd
      dysk
      erdtree
      xcp
      miniserve
      vhs
      presenterm
      d2
      tup
      imagemagick
      typst
      step-cli
      watchexec
      imv
      beancount

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
      swww
      grim
      slurp
      satty
      cliphist
      wl-clipboard
      wl-screenrec
      file
      yt-dlp
      rofi-power-menu
      rofi-rbw
      alsa-utils
      mpc-cli
      bc
      ffmpeg

      # programming
      rustup
      go
      delve
      enhanced-python
      ruff
      dive
      kubectl
      kubectx
      kubernetes-helm
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
}
