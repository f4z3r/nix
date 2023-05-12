{ pkgs, lib, username, theme ? "dark", ... }:

assert lib.asserts.assertOneOf "theme" theme [
  "dark"
  "light"
];

{
  imports = [
    ./bspwm/default.nix
    (import ./sxhkd/default.nix { inherit pkgs username; })
    ./polybar/default.nix
    ./picom/default.nix
    ./rofi/default.nix
    (import ./git/default.nix { inherit pkgs theme; })
    (import ./wezterm/default.nix { inherit pkgs theme; })
    (import ./tmux/default.nix {inherit pkgs theme; })
    (import ./zsh/default.nix { inherit pkgs theme; })
    ./starship/default.nix
    ./gpg/default.nix
    ./nvim/default.nix
    ./broot/default.nix
    (import ./bat/default.nix { inherit pkgs theme; })
    (import ./mpd/default.nix { inherit pkgs username; })
  ];

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = false;
        };
      };
    };

    rbw = {
      enable = true;
      settings = {
        email = "jakobbeckmann@pm.me";
        pinentry = "curses";
      };
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    feh.enable = true;
    bottom.enable = true;

    exa = {
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
      python-packages = ps: with ps; [
      ];
      enhanced-python = pkgs.python311.withPackages python-packages;
    in [
      # GUI programs
      gimp
      brave
      helvum
      onlyoffice-bin

      # utils
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
      vimv-rs
      lfs
      erdtree
      xcp

      # stuff not used often, installed via nix-shell
      #miniserve
      #tokei
      #jless
      #pastel

      # stuff used for GTK theming
      gtk-engine-murrine

      # nix l
      rnix-lsp

      xsel

      # stuff used in the background
      ctags
      rofi-power-menu
      rofi-rbw
      wmctrl
      bsp-layout
      alsa-utils
      mpc-cli
      uair
      bc
      ffmpeg

      # quick scripting stuff
      enhanced-python
      ruff
      black
    ];

    file = {
      ".config/ruff/pyproject.toml" = {
        source = ./files/ruff.toml;
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = (if theme == "dark" then "Gruvbox-Dark-BL" else "Gruvbox-Light-BL");
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = (if theme == "dark" then "Papirus-Dark" else "Papirus-Light");
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = (if theme == "dark" then "Capitaine Cursors (Gruvbox) - White" else "Capitaine Cursors (Gruvbox)");
    };
  };
}
