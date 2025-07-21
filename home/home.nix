{
  pkgs,
  lib,
  stdenv,
  pkgs-custom,
  scale,
  username,
  theme ? "dark",
  font_size,
  resolution,
  main_monitor,
  monitor_prefix,
  ...
}:
assert lib.asserts.assertOneOf "theme" theme ["dark" "light"]; let
  gtkTheme =
    if theme == "dark"
    then "Materia-dark"
    else "Materia-light";
  iconTheme =
    if theme == "dark"
    then "Papirus-Dark"
    else "Papirus-Light";
  cursorTheme =
    if theme == "dark"
    then "Capitaine Cursors (Gruvbox) - White"
    else "Capitaine Cursors (Gruvbox)";
  colors = import ./../theme.nix {inherit theme;};
in {
  imports = [
    (import ./langs/lua.nix {inherit pkgs lib;})
    (import ./apps/hyprland/default.nix {
      inherit pkgs pkgs-custom username resolution scale main_monitor monitor_prefix theme;
    })
    (import ./apps/ghostty.nix {inherit pkgs pkgs-custom theme;})
    (import ./apps/rofi/default.nix {inherit pkgs theme;})
    (import ./apps/git/default.nix {inherit pkgs theme;})
    (import ./apps/lazygit.nix {inherit pkgs theme;})
    (import ./apps/tmux/default.nix {inherit pkgs lib stdenv theme;})
    (import ./apps/fish/default.nix {inherit lib pkgs pkgs-custom theme;})
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    (import ./apps/broot.nix {inherit pkgs theme;})
    (import ./apps/k9s/default.nix {inherit pkgs theme;})
    (import ./apps/bat.nix {inherit pkgs theme;})
    (import ./apps/mpd/default.nix {inherit pkgs username;})
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
          pylsp-mypy
          presenterm-export
        ];
      enhanced-python = pkgs.python312.withPackages python-packages;
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
      dprint
      rsync
      dogdns
      fend
      ouch
      fd
      vimv-rs
      dysk
      erdtree
      xcp
      miniserve
      vhs
      pandoc
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
      cargo
      cargo-nextest
      rustc
      go
      delve
      enhanced-python
      ruff
      black
      dive
      kubectl
      kubectx
      kubernetes-helm
    ];

    file = {
      ".config/ruff/pyproject.toml" = {source = ./files/ruff.toml;};
      ".config/presenterm/config.yaml" = {source = ./files/presenterm.yaml;};
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
