{
  pkgs,
  pkgs-stable,
  lib,
  stdenv,
  pkgs-custom,
  theme ? "dark",
  ...
}: let
  username = "root";
  colors = import ../theme.nix {inherit theme;};
in {
  imports = [
    (import ./langs/lua.nix {inherit pkgs lib username;})
    (import ./apps/git/default.nix {inherit pkgs theme;})
    (import ./apps/lazygit.nix {inherit pkgs theme;})
    (import ./apps/tmux/default.nix {inherit pkgs lib stdenv theme;})
    ./apps/starship.nix
    ./apps/gpg.nix
    (import ./apps/nvim/default.nix {inherit pkgs pkgs-stable pkgs-custom;})
    (import ./apps/broot.nix {inherit pkgs theme;})
    (import ./apps/k9s/default.nix {inherit pkgs theme;})
    (import ./apps/bat.nix {inherit pkgs theme;})
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
    pkgs-stable.dprint
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

    # TODO: add clipboard selection if possiblk
    satty
    file
    bc
    ffmpeg
    atuin

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

    bash = {
      # TODO(@f4z3r): add theme and stuff
      enable = true;
      sessionVariables = {
        NIX_THEME = theme;
        NIXPKGS_ALLOW_UNFREE = 1;
        D2_LAYOUT = "elk";
        D2_THEME = "200";
        NIX_OPAQUE_NVIM = 1;
      };
      initExtra = ''
        __interactive_sofa () {
          tput rmkx
          output="$(sofa -i)"
          tput smkx
          READLINE_LINE=$${output}
          READLINE_POINT=$${#READLINE_LINE}
        }
        bind -x '"\C-o": __interactive_sofa'
      '';
      shellAliases = {
        rt = ''z $( if git rev-parse --show-toplevel &> /dev/null; git rev-parse --show-toplevel; else; echo "."; end )'';
        sk = ''sk -m --color="dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1"'';
        skd = ''z "$(fd -t d -c always -L -H . ./ | sk --ansi)"'';
        ska = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}"' '';
        ag = ''ag --hidden --ignore .git --ignore .cache --color'';
        l = ''eza -F -a'';
        ll = ''eza -aglF --git'';
        cp = "xcp";
        erd = "erd -IHl";
        k = ''kubectl'';
        kn = ''kubens'';
        kc = ''kubectx'';
        ks = ''stern'';
        tree = ''tree -C'';
        ip = ''ip -c'';
        feh = ''feh -Fx'';
        pdf = ''mupdf'';
        lg = ''lazygit'';
        grep = ''grep --color=auto'';
        egrep = ''egrep --color=auto'';
        fgrep = ''fgrep --color=auto'';
        nix-shell = ''nix-shell --run fish'';
        wall = ''swww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
        ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --exclude '/.**' --exclude '**/.**' --exclude '**/tags' --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';
        jwt = ''wl-paste | step crypto jwt inspect --insecure | jq'';
        imv = ''imv -b ffffff'';
      };
    };

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
