{
  pkgs,
  pkgs-stable,
  lib,
  stdenv,
  pkgs-custom,
  theme ? "dark",
  ...
}: let
  colors = import ./theme.nix {inherit theme;};
in {
  imports = [
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "root";
  home.homeDirectory = "/root";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; let
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
        black
      ];
    enhanced-python = pkgs.python313.withPackages python-packages;
  in [
    # utils
    devbox
    zip
    just
    gnumake
    gcc
    openssl
    rclone
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

    gopass

    satty
    cliphist
    file
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
    dive
    kubectl
    kubectx
    kubernetes-helm
  ];
  home.file = {
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
  };
  home.sessionVariables = {
    DO_NOT_TRACK = "1";
    FZF_TMUX_OPTS = "-p80%,60%";
    FZF_DEFAULT_OPTS =
      if theme == "dark"
      then "--color bg:#282828,bg+:#282828,fg:#d4be98,fg+:#d3869b,header:#7daea3,hl:#89b482,hl+:#d3869b,info:#e78a4e,marker:#a9b665,pointer:#d3869b,prompt:#ea6962,spinner:#e78a4e"
      else "--color bg:#fbf1c7,bg+:#fbf1c7,fg:#654735,fg+:#945e80,header:#45707a,hl:#4c7a5d,hl+:#945e80,info:#c35e0a,marker:#6c782e,pointer:#945e80,prompt:#c14a4a,spinner:#c35e0a";
  };

  programs = {
    home-manager.enable = true;

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

    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

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
}
