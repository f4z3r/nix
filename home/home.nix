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
      silver-searcher
      procs
      tree
      jq
      rsync
      curlie
      dog

      rnix-lsp

      xsel

      rofi-power-menu
      bsp-layout
      alsa-utils
      mpc-cli
      uair
      libnotify
      bc

      protonvpn-cli

      python311
    ];
  };

  gtk = {
    theme = {
      package = pkgs.sweet;
      name = "Sweet";
    };
  };
}
