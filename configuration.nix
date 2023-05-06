{ config, pkgs, system, username, hostname, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      (import ./nixos/networking.nix { inherit config pkgs hostname; })
      ./nixos/tlp.nix
      ./nixos/zsh.nix
      ./nixos/openvpn/default.nix
      ./nixos/kanata.nix
    ];

  boot.loader = {
    timeout = 1;
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };


  boot.initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
    };
    luks.devices = {
      "luks-d8862d2e-20cd-41a7-be46-043a7f66e1ec" = {
        device = "/dev/disk/by-uuid/d8862d2e-20cd-41a7-be46-043a7f66e1ec";
        keyFile = "/crypto_keyfile.bin";
      };
    };
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

    settings = {
      auto-optimise-store = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

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
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "FiraCode Nerd Font" ];
      };
    };
  };

  services.xserver = {
    enable = true;
    dpi = 192;
    videoDrivers = [ "nvidia" ];
    
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    windowManager = {
      bspwm = {
        enable = true;
      };
    };

    displayManager = {
      defaultSession = "none+bspwm";
      autoLogin = {
        enable = true;
        user = "${username}";
      };
      lightdm = {
        enable = true;
      };
    };

    layout = "us";
    xkbVariant = "alt-intl";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };


  programs = {
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.xsecurelock}/bin/xsecurelock";
    };

    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    };

    dconf.enable = true;
    thunar.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    man-pages
    brightnessctl
    xdotool
    xsecurelock
  ];

  services = {
    blueman.enable = true;
    timesyncd.enable = true;
    thermald.enable = true;

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
      webInterface = false;
    };
  };

  system.stateVersion = "22.11";
}
