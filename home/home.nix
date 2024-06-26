{
  pkgs,
  lib,
  stdenv,
  pkgs-custom,
  hostname,
  username,
  theme ? "dark",
  polybar_dpi,
  font_size,
  scratch_res,
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
in {
  imports = [
    (import ./langs/lua.nix {inherit pkgs lib;})
    (import ./apps/bspwm/default.nix {
      inherit pkgs hostname scratch_res main_monitor monitor_prefix theme;
    })
    (import ./apps/sxhkd/default.nix {inherit pkgs username;})
    (import ./apps/polybar/default.nix {
      inherit pkgs polybar_dpi main_monitor monitor_prefix theme;
    })
    ./apps/picom.nix
    ./apps/rofi/default.nix
    (import ./apps/git/default.nix {inherit pkgs theme;})
    (import ./apps/lazygit.nix {inherit pkgs theme;})
    (import ./apps/wezterm.nix {inherit pkgs theme font_size;})
    (import ./apps/tmux/default.nix {inherit pkgs lib stdenv theme;})
    (import ./apps/fish/default.nix {inherit lib pkgs theme;})
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    ./apps/broot.nix
    ./apps/k9s/default.nix
    (import ./apps/bat.nix {inherit pkgs theme;})
    (import ./apps/mpd/default.nix {inherit pkgs username;})
  ];

  programs = {
    home-manager.enable = true;

    mpv.enable = true;

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
    bottom.enable = true;

    eza = {
      enable = true;
      icons = true;
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

    autorandr = {
      enable = true;
      ignoreLid = true;
    };

    redshift = {
      enable = true;
      dawnTime = "06:00";
      duskTime = "19:00";
    };

    flameshot.enable = true;
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
        ];
      enhanced-python = pkgs.python311.withPackages python-packages;
    in [
      # GUI programs
      gimp
      brave
      helvum
      onlyoffice-bin
      obs-studio
      flowblade
      signal-desktop
      ticktick

      # utils
      zip
      just
      gnumake
      gcc
      openssl
      rclone
      neofetch
      mupdf
      ripgrep
      silver-searcher
      procs
      tree
      jq
      rsync
      xh
      dogdns
      fend
      autorandr
      ouch
      fd
      gfold
      vimv-rs
      dysk
      erdtree
      xcp
      xsel
      miniserve
      vhs
      pandoc
      presenterm
      d2
      imagemagick

      # stuff not used often, installed via nix-shell
      #tokei
      #jless
      #pastel

      # stuff used for GTK theming
      gtk-engine-murrine

      # stuff used in the background
      file
      yt-dlp
      rofi-power-menu
      rofi-rbw
      wmctrl
      alsa-utils
      mpc-cli
      bc
      ffmpeg
      fzf

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
      ".local/bin/mip" = {
        source = ./scripts/mip;
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
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
