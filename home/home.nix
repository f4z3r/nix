{ pkgs, ... }:

{
  imports = [
    ./bluetooth/default.nix
    ./bspwm/default.nix
    ./sxhkd/default.nix
    ./polybar/default.nix
    ./picom/default.nix
    ./rofi/default.nix
    ./git/default.nix
    ./wezterm/default.nix
    ./tmux/default.nix
    ./zsh/default.nix
    ./starship/default.nix
    ./gpg/default.nix
    ./nvim/default.nix
    ./broot/default.nix
    ./bat/default.nix
  ];

  programs = {
    home-manager.enable = true;
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
      musicDirectory = /home/f4z3r/Music;
      # TODO(@jakob): configure
    };

    redshift = {
      enable = true;
      dawnTime = "06:00";
      duskTime = "19:00";
    };
  };

  home = {
    username = "f4z3r";
    homeDirectory = "/home/f4z3r";
    stateVersion = "22.11";
    packages = with pkgs; [
      gimp
      brave

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
      dog
      fend

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
    ];
  };

  gtk = {
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL";
    };
  };
}
