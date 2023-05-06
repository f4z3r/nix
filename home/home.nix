{ pkgs, lib, username, theme ? "dark", ... }:

assert lib.asserts.assertOneOf "theme" theme [
  "dark"
  "light"
];

{
  imports = [
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
      # GUI programs
      gimp
      brave
      helvum

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

      # quick scripting stuff
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
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = (if theme == "dark" then "Capitaine Cursors (Gruvbox) - White" else "Capitaine Cursors (Gruvbox)");
    };
  };
}
