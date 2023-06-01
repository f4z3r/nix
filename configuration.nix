{ config, lib, pkgs, system, username, hostname, dpi, brain_backup, ... }:

{
  imports = [
    ./${hostname}-hardware-configuration.nix
    (import ./nixos/networking.nix { inherit config pkgs hostname; })
    ./nixos/virtualisation.nix
    (import ./nixos/clamav.nix { inherit config pkgs username; })
    (import ./nixos/restic.nix { inherit config pkgs username brain_backup; })
    ./nixos/tlp.nix
    ./nixos/zsh.nix
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
      efi = { canTouchEfiVariables = true; };
    };
  };

  hardware = {
    opengl.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
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

    settings = { auto-optimise-store = true; };
  };

  nixpkgs.config.allowUnfree = true;

  system = { autoUpgrade = { enable = false; }; };

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
    fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "FiraCode Nerd Font" ];
      };
    };
  };

  services.xserver = {
    inherit dpi;
    enable = true;

    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    windowManager = { bspwm = { enable = true; }; };

    displayManager = {
      defaultSession = "none+bspwm";
      autoLogin = {
        enable = true;
        user = "${username}";
      };
      lightdm = { enable = true; };
    };

    layout = "us";
    xkbVariant = "alt-intl";
  };

  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        description = "${username}";
        extraGroups =
          [ "networkmanager" "wheel" "audio" "video" "podman" "docker" ];
        shell = pkgs.zsh;
        packages = with pkgs; [ ];
      };
    };
    groups = { users.members = [ "${username}" "clamav" ]; };
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
    vim
    git
    man-pages
    brightnessctl
    xdotool
    xsecurelock
    libnotify
  ];

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
      webInterface = false;
    };
  };

  security.sudo = {
    extraConfig = ''
      Defaults insults
    '';
    extraRules = [{
      users = [ "clamav" ];
      runAs = "${username}";
      commands = [{
        command = "${pkgs.libnotify}/bin/notify-send";
        options = [ "NOPASSWD" "SETENV" ];
      }];
    }];
  };

  system.stateVersion = "22.11";
}
