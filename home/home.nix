{ pkgs, lib, hostname, username, theme ? "dark", polybar_dpi, font_size, scratch_res, ... }:

assert lib.asserts.assertOneOf "theme" theme [
  "dark"
  "light"
];

let
  lua-packages = with pkgs.luajitPackages; [
    luv
    luacheck
    luasec
    luasocket
    luafilesystem
    penlight
    lualogging
    rapidjson
  ];
in

{
  imports = [
    (import ./apps/bspwm/default.nix { inherit pkgs hostname scratch_res; })
    (import ./apps/sxhkd/default.nix { inherit pkgs username; })
    (import ./apps/polybar/default.nix { inherit pkgs polybar_dpi; })
    ./apps/picom.nix
    ./apps/rofi/default.nix
    (import ./apps/git/default.nix { inherit pkgs theme; })
    (import ./apps/wezterm.nix { inherit pkgs theme font_size; })
    (import ./apps/tmux.nix {inherit pkgs theme; })
    (import ./apps/zsh/default.nix { inherit lib pkgs theme lua-packages; })
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    ./apps/broot.nix
    (import ./apps/bat.nix { inherit pkgs theme; })
    (import ./apps/mpd/default.nix { inherit pkgs username; })
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
        jedi-language-server
        debugpy
        pip
        virtualenv
        setuptools
      ];
      enhanced-python = pkgs.python310.withPackages python-packages;
    in [
      # GUI programs
      gimp
      brave
      helvum
      onlyoffice-bin

      # utils
      gcc
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
      vimv-rs
      lfs
      erdtree
      xcp
      xsel
      miniserve

      # stuff not used often, installed via nix-shell
      #tokei
      #jless
      #pastel

      # stuff used for GTK theming
      gtk-engine-murrine

      # stuff used in the background
      rofi-power-menu
      rofi-rbw
      wmctrl
      bsp-layout
      alsa-utils
      mpc-cli
      uair
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
      luajit
    ] ++ lua-packages;

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
      name = if theme == "dark" then "Gruvbox-Dark-BL" else "Gruvbox-Light-BL";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = if theme == "dark" then "Papirus-Dark" else "Papirus-Light";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = if theme == "dark" then "Capitaine Cursors (Gruvbox) - White" else "Capitaine Cursors (Gruvbox)";
    };
  };
}
