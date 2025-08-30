{
  config,
  lib,
  pkgs,
  pkgs-stable,
  theme,
  hostname,
  usernames,
  default_user,
  brain_backup,
  monitoring,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  secrets = import ./secrets.nix;
in {
  imports = [
    ./${hostname}-hardware-configuration.nix
    (import ./nixos/networking.nix {inherit config pkgs hostname;})
    ./nixos/virtualisation.nix
    (import ./nixos/clamav.nix {inherit config pkgs usernames;})
    (import ./nixos/restic.nix {inherit config pkgs brain_backup usernames;})
    ./nixos/tlp.nix
    ./nixos/fish.nix
    ./nixos/openvpn/default.nix
    ./nixos/kanata.nix
    (import ./nixos/work.nix {inherit pkgs;})
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

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [intel-media-driver intel-vaapi-driver libvdpau-va-gl];
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {General = {Enable = "Source,Sink,Media,Socket";};};
    };
  };

  networking.useDHCP = lib.mkDefault true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

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

    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gtk2;
      };
    };

    dconf.enable = true;
    thunar.enable = true;
  };

  environment = {
    sessionVariables = {
      DO_NOT_TRACK = "1";
      FZF_TMUX_OPTS = "-p80%,60%";
      FZF_DEFAULT_OPTS =
        if theme == "dark"
        then "--color bg:#282828,bg+:#282828,fg:#d4be98,fg+:#d3869b,header:#7daea3,hl:#89b482,hl+:#d3869b,info:#e78a4e,marker:#a9b665,pointer:#d3869b,prompt:#ea6962,spinner:#e78a4e"
        else "--color bg:#fbf1c7,bg+:#fbf1c7,fg:#654735,fg+:#945e80,header:#45707a,hl:#4c7a5d,hl+:#945e80,info:#c35e0a,marker:#6c782e,pointer:#945e80,prompt:#c14a4a,spinner:#c35e0a";
      LIBVA_DRIVER_NAME = "iHD";
      NIXOS_OZONE_WL = "1";
    };

    extraInit = "umask 0077";

    systemPackages = with pkgs; [
      vim
      git
      man-pages
      brightnessctl
      libnotify
    ];

    etc = {
      "nixos/restic-password" = {
        mode = "0600";
        text = secrets.restic.password;
      };
      "nixos/vpn/ca" = {
        mode = "0600";
        text = secrets.vpn.ca;
      };
      "nixos/vpn/tls-auth" = {
        mode = "0600";
        text = secrets.vpn.tls-auth;
      };
      "nixos/vpn/account.cred" = {
        mode = "0600";
        text = secrets.vpn.creds;
      };
    };
  };

  services = {
    prometheus = {
      enable = monitoring;
      port = 9090;
      globalConfig.scrape_interval = "10s"; # "1m"
      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [
            {
              targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
            }
          ];
        }
      ];
      exporters = {
        node = {
          enable = monitoring;
          port = 9000;
          # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
          enabledCollectors = ["systemd"];
          # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
          extraFlags = ["--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" "--collector.wifi"];
        };
      };
    };

    grafana = {
      enable = monitoring;
      provision.datasources.settings.datasources = [
        {
          name = "prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
      ];
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
          domain = "grafana.localhost";
        };
        security = {
          admin_user = "admin";
          admin_password = "admin";
        };
      };
    };

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
    thermald.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 3;
      criticalPowerAction = "HybridSleep";
    };

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

  security = {
    polkit.enable = true;
    pam.makeHomeDir.umask = "0077";
  };

  system.stateVersion = "22.11";
}
