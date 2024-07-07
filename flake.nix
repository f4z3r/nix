{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    neorg-overlay,
    ...
  }: let
    username = "f4z3r";
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
      dpi,
      polybar_dpi,
      font_size,
      resolution,
      brain_backup,
      main_monitor,
      monitor_prefix,
    }:
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            system
            pkgs-custom
            username
            hostname
            dpi
            brain_backup
            main_monitor
            monitor_prefix
            ;
        };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [neorg-overlay.overlays.default];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                ${username} = import ./home/home.nix {
                  inherit
                    pkgs
                    lib
                    stdenv
                    pkgs-custom
                    hostname
                    username
                    theme
                    polybar_dpi
                    font_size
                    resolution
                    main_monitor
                    monitor_prefix
                    ;
                };
              };
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      "revenge-nix" = setup {
        hostname = "revenge-nix";
        dpi = 192;
        polybar_dpi = 128;
        font_size = 19;
        resolution = "3840x2160";
        brain_backup = true;
        # update the following to the "nix" values if disabling nvidia sync
        main_monitor = "eDP-1-1";
        monitor_prefix = "DP-1";
      };
      "nix" = setup {
        hostname = "nix";
        dpi = 91;
        polybar_dpi = 65;
        font_size = 11;
        resolution = "1920x1200";
        brain_backup = true;
        main_monitor = "eDP-1";
        monitor_prefix = "DP";
      };
    };
  };
}
