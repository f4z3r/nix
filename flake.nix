{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    kolide-launcher = {
      url = "github:/f4z3r/nix-agent/feat/osqueryflag";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    lix-module,
    home-manager,
    neorg-overlay,
    kolide-launcher,
    ...
  } @ inputs: let
    usernames = [
      # add a user here to create a separate account that is identical in terms of configuration
      # default password will be changeme
      "f4z3r"
    ];
    default_user = "f4z3r";
    theme = "dark"; # one of "light" or "dark"
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    inherit (nixpkgs) lib;
    pkgs-custom = {
    };
    inherit (pkgs) stdenv;

    setup = {
      hostname,
      font_size,
      resolution,
      scale,
      brain_backup,
      main_monitor,
      monitor_prefix,
      monitoring,
    }:
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            system
            pkgs-custom
            theme
            hostname
            usernames
            default_user
            brain_backup
            main_monitor
            monitor_prefix
            monitoring
            ;
        };
        modules = [
          lix-module.nixosModules.default

          ./configuration.nix

          kolide-launcher.nixosModules.kolide-launcher

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              neorg-overlay.overlays.default
              (final: prev: {
                clamav = prev.clamav.overrideAttrs (old: rec {
                  version = "1.4.0";
                  src = pkgs.fetchurl {
                    url = "https://www.clamav.net/downloads/production/${old.pname}-${version}.tar.gz";
                    hash = "sha256-1nqymeXKBdrT2imaXqc9YCCTcqW+zX8TuaM8KQM4pOY=";
                  };
                });
              })
            ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users =
                lib.attrsets.genAttrs
                usernames (user:
                  import ./home/home.nix {
                    inherit
                      pkgs
                      lib
                      stdenv
                      pkgs-custom
                      theme
                      font_size
                      resolution
                      scale
                      main_monitor
                      monitor_prefix
                      ;
                    username = user;
                  });
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      "revenge-nix" = setup {
        hostname = "revenge-nix";
        font_size = 11;
        resolution = "3840x2160";
        scale = 2;
        brain_backup = true;
        # potential update to these when using nvidia sync
        main_monitor = "eDP-1";
        monitor_prefix = "DP";
        monitoring = true;
      };
      "nix" = setup {
        hostname = "nix";
        font_size = 11;
        resolution = "1920x1200";
        scale = 1;
        brain_backup = true;
        main_monitor = "eDP-1";
        monitor_prefix = "DP";
        monitoring = false;
      };
    };
  };
}
