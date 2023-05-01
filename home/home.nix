{ pkgs, lib, username, theme ? "dark", ... }:

assert lib.asserts.assertOneOf "theme" theme [
  "dark"
  "light"
];

{
  imports = [
    ./bluetooth/default.nix
    ./bspwm/default.nix
    ./sxhkd/default.nix
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

    ncmpcpp = {
      enable = true;
      # TODO(@jakob): configure
    };
  };

  services = {
    dunst = {
      enable = true;
      # TODO(@jakob): configure
    };

    autorandr = {
      enable = true;
      ignoreLid = true;
    };

    mpd = {
      enable = true;
      musicDirectory = /home/${username}/Music;
      # TODO(@jakob): configure
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
    packages = with pkgs; [
      gimp
      brave
      helvum

      ctags
      neofetch
      mupdf
      ripgrep
      silver-searcher
      procs
      tree
      jq
      rsync
      curlie
      dogdns
      fend
      autorandr
      ouch

      gtk-engine-murrine

      rnix-lsp

      xsel

      rofi-power-menu
      rofi-rbw
      wmctrl
      bsp-layout
      alsa-utils
      mpc-cli
      uair
      libnotify

      python311
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
  };
}
