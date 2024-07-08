{
  config,
  lib,
  pkgs,
  system,
  username,
  hostname,
  dpi,
  brain_backup,
  ...
}: {
  imports = [
    ./${hostname}-hardware-configuration.nix
    (import ./nixos/networking.nix {inherit config pkgs hostname;})
    ./nixos/virtualisation.nix
    (import ./nixos/clamav.nix {inherit config pkgs username;})
    (import ./nixos/restic.nix {inherit config pkgs username brain_backup;})
    ./nixos/tlp.nix
    ./nixos/fish.nix
    ./nixos/openvpn/default.nix
    ./nixos/kanata.nix
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

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ intel-media-driver intel-vaapi-driver libvdpau-va-gl ];
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
    package = pkgs.nixFlakes;
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

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      volumeStep = "3%";
    };
  };

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
    packages = with pkgs; [(nerdfonts.override {fonts = ["FiraCode" "SourceCodePro"];})];

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono"];
        sansSerif = ["FiraCode Nerd Font"];
      };
    };
  };

  services = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "f4z3r";
        };
        default_session = initial_session;
      };
    };

    udev = {
      enable = true;
      extraRules = ''
        # Rules for Oryx web flashing and live training
        KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

        # Legacy rules for live training over webusb (Not needed for firmware v21+)
          # Rule for all ZSA keyboards
          SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
          # Rule for the Moonlander
          SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
          # Rule for the Ergodox EZ
          SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
          # Rule for the Planck EZ
          SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

        # Wally Flashing rules for the Ergodox EZ
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

        # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
        # Keymapp Flashing rules for the Voyager
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"

      '';
    };
  };

  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = ["networkmanager" "wheel" "audio" "video" "podman" "docker" "plugdev"];
        shell = pkgs.fish;
        packages = [];
      };
    };
    groups = {
      users = {
        members = ["${username}" "clamav"];
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
      LIBVA_DRIVER_NAME = "iHD";
      # NIXOS_OZONE_WL = "1";
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

    logind = {
      lidSwitch = "lock";
      lidSwitchExternalPower = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
      '';
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    printing = {
      enable = true;
      stateless = true;
      startWhenNeeded = true;
      webInterface = true;
    };
  };

  security = {
    sudo = {
      execWheelOnly = true;
      extraRules = [
        {
          users = ["clamav"];
          runAs = "${username}";
          commands = [
            {
              command = "${pkgs.libnotify}/bin/notify-send";
              options = ["NOPASSWD" "SETENV"];
            }
          ];
        }
      ];
    };
    polkit.enable = true;
  };

  system.stateVersion = "22.11";
}
