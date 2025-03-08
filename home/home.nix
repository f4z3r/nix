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
  fg =
    if theme == "dark"
    then "#d4be98"
    else "#654735";
  bg =
    if theme == "dark"
    then "#282828"
    else "#fbf1c7";
  red =
    if theme == "dark"
    then "#ea6962"
    else "#c14a4a";
  blue =
    if theme == "dark"
    then "#7daea3"
    else "#45707a";
  purple =
    if theme == "dark"
    then "#d3869b"
    else "#945e80";
  green =
    if theme == "dark"
    then "#a9b665"
    else "#6c782e";
  orange =
    if theme == "dark"
    then "#e78a4e"
    else "#c35e0a";
  aqua =
    if theme == "dark"
    then "#89b482"
    else "#4c7a5d";
in {
  imports = [
    (import ./langs/lua.nix {inherit pkgs lib;})
    (import ./apps/hyprland/default.nix {
      inherit pkgs pkgs-custom username resolution scale main_monitor monitor_prefix theme;
    })
    ./apps/rofi/default.nix
    (import ./apps/git/default.nix {inherit pkgs theme;})
    (import ./apps/lazygit.nix {inherit pkgs theme;})
    (import ./apps/tmux/default.nix {inherit pkgs lib stdenv theme;})
    (import ./apps/fish/default.nix {inherit lib pkgs pkgs-custom theme;})
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    ./apps/broot.nix
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
        inherit bg fg;
        "bg+" = bg;
        "fg+" = purple;
        hl = aqua;
        "hl+" = purple;
        info = orange;
        marker = green;
        prompt = red;
        spinner = orange;
        pointer = purple;
        header = blue;
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
          follow = "keyboard";
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
      };
    };

    gammastep = {
      enable = true;
      dawnTime = "06:00";
      duskTime = "19:00";
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

      # stuff not used often, installed via nix-shell
      #tokei
      #jless
      #pastel

      # stuff used for GTK theming
      gtk-engine-murrine

      # stuff used in the background
      ollama
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
      "revive.toml" = {source = ./files/revive.toml;};
      ".config/ghostty/config" = {source = ./files/ghostty.toml;};
      ".local/bin/mip" = {
        source = ./scripts/mip;
        executable = true;
      };
      ".local/bin/gcl" = {
        source = ./scripts/gcl;
        executable = true;
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
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = theme == "dark";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = theme == "dark";
    };
  };
}
