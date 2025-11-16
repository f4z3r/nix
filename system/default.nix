{
  config,
  lib,
  pkgs,
  pkgs-stable,
  hostname,
  usernames,
  default_user,
  monitoring,
  secrets,
  colors,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in {
  imports = [
    ../hardware/common.nix
    ../hardware/${hostname}.nix

    ./power-management.nix
    ./kanata.nix
    (import ./security {inherit lib pkgs hostname usernames secrets;})
    ./virtualisation.nix
    (import ./restic.nix {inherit usernames secrets;})
    (import ./work.nix {inherit pkgs secrets;})
    (import ./monitoring.nix {inherit config monitoring;})
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 1;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        editor = false;
      };
      efi = {canTouchEfiVariables = true;};
    };
    tmp = {cleanOnBoot = true;};
  };

  # due to security advisory, see: https://github.com/NixOS/nixpkgs/security/advisories/GHSA-m7pq-h9p4-8rr4
  systemd.shutdownRamfs.enable = false;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {auto-optimise-store = true;};
  };

  nixpkgs.config.allowUnfree = true;

  system = {autoUpgrade = {enable = false;};};

  time.timeZone = "Europe/Zurich";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.sauce-code-pro
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono"];
        sansSerif = ["FiraCode Nerd Font"];
      };
    };
  };

  users = {
    mutableUsers = true;
    users = lib.attrsets.genAttrs usernames (user: {
      initialPassword = "changeme";
      isNormalUser = true;
      description = "${user}";
      extraGroups = ["networkmanager" "wheel" "audio" "video" "podman" "docker" "plugdev"];
      shell = pkgs.fish;
      packages = [];
    });
    groups = {
      users = {
        members = builtins.concatLists [usernames ["clamav"]];
      };
    };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    fish = {
      enable = true;
      useBabelfish = true;
    };

    dconf.enable = true;
    thunar.enable = true;
  };

  environment = {
    sessionVariables = {
      DO_NOT_TRACK = "1";
      FZF_TMUX_OPTS = "-p80%,60%";
      FZF_DEFAULT_OPTS =
        if colors.theme == "dark"
        then "--color bg:#282828,bg+:#282828,fg:#d4be98,fg+:#d3869b,header:#7daea3,hl:#89b482,hl+:#d3869b,info:#e78a4e,marker:#a9b665,pointer:#d3869b,prompt:#ea6962,spinner:#e78a4e"
        else "--color bg:#fbf1c7,bg+:#fbf1c7,fg:#654735,fg+:#945e80,header:#45707a,hl:#4c7a5d,hl+:#945e80,info:#c35e0a,marker:#6c782e,pointer:#945e80,prompt:#c14a4a,spinner:#c35e0a";
      LIBVA_DRIVER_NAME = "iHD";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
    };

    systemPackages = with pkgs; [
      vim
      git
      man-pages
      brightnessctl
      libnotify
    ];
  };

  services = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    fwupd.enable = true;

    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${session}";
          user = default_user;
        };
        default_session = {
          command = "${tuigreet} --asterisks --remember -t -c ${session}";
          user = "greeter";
        };
      };
    };

    udev = {
      enable = true;
      extraRules = ''
        # stop charging battery using upower rules
        SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="/bin/sh -c 'echo 90 > /sys/class/power_supply/BAT0/charge_control_end_threshold'"

        # vial rules
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
    };

    blueman.enable = true;
    timesyncd.enable = true;

    locate = {
      enable = true;
      interval = "hourly";
    };

    logind.settings.Login = {
      lidSwitch = "lock";
      lidSwitchExternalPower = "ignore";
      HandlePowerKey = "ignore";
    };

    pipewire = {
      enable = true;
      package = pkgs-stable.pipewire;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        package = pkgs-stable.wireplumber;
      };
    };

    printing = {
      enable = true;
      stateless = false;
      startWhenNeeded = true;
      webInterface = true;
      browsed.enable = true;
    };
  };

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        # see https://mimetype.io/all-types
        "image/bmp" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "image/pjpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/tiff" = "imv.desktop";
        "image/x-bmp" = "imv.desktop";
        "image/x-pcx" = "imv.desktop";
        "image/x-png" = "imv.desktop";
        "image/x-portable-anymap" = "imv.desktop";
        "image/x-portable-bitmap" = "imv.desktop";
        "image/x-portable-graymap" = "imv.desktop";
        "image/x-portable-pixmap" = "imv.desktop";
        "image/x-tga" = "imv.desktop";
        "image/x-xbitmap" = "imv.desktop";
      };
    };
  };

  system.stateVersion = "22.11";
}
