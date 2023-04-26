# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  username = "f4z3r";
  hostname = "revenge-nix";
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
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


  # Setup keyfile
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

  # Enable swap on luks

  networking.hostName = "${hostname}"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      auto-optimise-store = true;
    };
  };

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraMono" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FuraMono Nerd Font Mono" ];
        sansSerif = [ "FuraMono Nerd Font" ];
      };
    };
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    dpi = 192;
    
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
        user = "f4z3r";
      };
      lightdm = {
        enable = true;
      };
    };

    layout = "us";
    xkbVariant = "alt-intl";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "f4z3r";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    };
    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" "pattern" ];
        styles = {
          "unknown-token" = "fg=red,dim,bold";
          "reserved-word" = "fg=red";
          "alias" = "fg=27";
          "suffix-alias" = "fg=27";
          "global-alias" = "fg=27";
          "builtin" = "fg=96";
          "function" = "fg=174,bold";
          "command" = "fg=blue";
          "precommand" = "fg=magenta,bold";
          "commandseparator" = "fg=52";
          "hashed-command" = "fg=blue";
          "autodirectory" = "fg=green";
          "path" = "fg=green";
          "path_prefix" = "fg=77";
          "globbing" = "fg=green,bold";
          "history-expansion" = "fg=red";
          "command-substitution" = "fg=blue";
          "command-substitution-delimiter" = "fg=52";
          "process-substitution" = "fg=blue";
          "process-substitution-delimiter" = "fg=52";
          "single-hyphen-option" = "fg=magenta";
          "double-hyphen-option" = "fg=magenta";
          "back-quoted-argument" = "fg=blue";
          "back-quoted-argument-unclosed" = "fg=red,dim";
          "back-quoted-argument-delimiter" = "fg=52";
          "single-quoted-argument" = "fg=3";
          "single-quoted-argument-unclosed" = "fg=red,dim";
          "double-quoted-argument" = "fg=3";
          "double-quoted-argument-unclosed" = "fg=red,dim";
          "dollar-quoted-argument" = "fg=cyan,bold";
          "dollar-quoted-argument-unclosed" = "fg=red,dim";
          "rc-quote" = "fg=3,bold";
          "dollar-double-quoted-argument" = "fg=cyan,bold";
          "back-double-quoted-argument" = "fg=cyan";
          "back-dollar-quoted-argument" = "fg=cyan";
          "assign" = "dim";
          "redirection" = "fg=red";
          "comment" = "fg=8";
          "named-fd" = "fg=58";
          "numeric-fd" = "fg=58";
          "arg0" = "fg=blue";
          "default" = "none";
          "bracket-level-1" = "fg=178";
          "bracket-level-2" = "fg=133";
          "bracket-level-3" = "fg=229";
          "bracket-level-4" = "fg=103";
          "cursor-matchingbracket" = "fg=green,bold";
          "bracket-error" = "bg=black,bold";
        };
        patterns = {
          "sudo rm *" = "fg=white,bold,bg=red";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    man-pages
    brightnessctl
    xdotool
  ];

  services = {
    blueman.enable = true;

    greenclip = {
      enable = true;
      # TODO(@jakob): configure
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

    kanata = {
      enable = true;
      keyboards.colemak = {
        devices = [ "/dev/input/event0" ];
        config = ''
          (defalias
            ;; layer toggles
            lyu (one-shot 2000 (layer-while-held up))
            lyd (one-shot 2000 (layer-while-held down))
            col (layer-switch colemakdh)
          
            ;; tapped shift
            tsh (tap-hold 100 100 ' rsft)
          
            ;; one-shot control
            osc (one-shot 2000 lctl)
          )
          (defsrc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]
            caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
            lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lmet lalt           spc            ralt rctl lft  down up   rght
          )
          
          (deflayer colemakdh
            tab  q    w    f    p    b    j    l    u    y    ;    bspc rsft
            lctl a    r    s    t    g    m    n    e    i    o    ret  @lyu ret
            lsft lmet x    c    d    v    z    k    h    ,    .    /    @tsh
            @col lalt @lyd           spc            @lyu rctl lft  down up   rght
          )
          
          (deflayer down
            esc  blup pgup brup volu pp   brk  7    8    9    .     bspc rsft
            del  bldn pgdn brdn vold ins  home 4    5    6    0     ret  @lyu ret
            S-6  _    _    _    mute sys  end  _    1    2    3    ,     @tsh
            _    _    @col           _              @lyu @osc mute  vold volu pp
          )
          
          (deflayer up
            grv  S-1  [    ]    S-4  S-5  _    f9   f10  f11  f12  S-2   ]
            +    =    S-9  S-0  S--  S-3  _    f5   f6   f7   f8   S-\   @col ret
            S-8  _    \    S-[  S-]  -    S-7  _    f1   f2   f3   f4   S-`
            _    _    _              _              @col rctl lft  down  up   rght
          )
        '';
        extraDefCfg = ''
          process-unmapped-keys yes
          danger-enable-cmd no
          sequence-timeout 1000
          sequence-input-mode visible-backspaced
          log-layer-changes no
          linux-continue-if-no-dev-found no
          linux-unicode-termination space
        '';
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
