{
  lib,
  pkgs,
  pkgs-stable,
  pkgs-custom,
  username,
  colors,
  stdenv,
  ...
}: let
  python = import ../langs/python.nix {inherit pkgs;};
in {
  imports = [
    (import ../langs/lua.nix {inherit lib pkgs username;})

    (import ../apps/fish {inherit pkgs colors;})
    (import ../apps/git {inherit pkgs colors;})
    (import ../apps/k9s.nix {inherit colors;})
    (import ../apps/lazygit.nix {inherit colors;})
    ../apps/mise.nix
    (import ../apps/nvim {inherit pkgs pkgs-stable pkgs-custom;})
    ../apps/starship.nix
    (import ../apps/tmux {inherit lib pkgs colors stdenv;})
    (import ../apps/tv {inherit pkgs colors;})
  ];

  programs = {
    bat = {
      enable = true;
      config.style = "numbers,changes,header";
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      historyWidget.command = "";

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
      settings.updates.auto_update = false;
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

  home.packages = with pkgs; [
    erdtree
    fd
    fend
    jq
    openssl
    ouch
    parallel
    prek
    presenterm
    procs
    rclone
    ripgrep
    rsync
    tree
    watchexec
    xcp
    yq-go
    zip
    gopass

    bc
    file
    step-cli

    # development
    cbfmt
    delve
    gcc
    gnumake
    go
    gofumpt
    goimports-reviser
    just
    kubectl
    kubectx
    kubernetes-helm
    pkgs-stable.dprint
    prettier
    python
    ruff
    shellharden
    shfmt
    stylua
    yamlfmt
  ];

  home.file = {
    "revive.toml".source = ../files/revive.toml;

    ".local/bin/mip" = {
      source = ../scripts/mip;
      executable = true;
    };

    ".local/bin/gcl" = {
      source = ../scripts/gcl;
      executable = true;
    };
  };
}
