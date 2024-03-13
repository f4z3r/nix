{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-terraform-1-3-7.url = "github:nixos/nixpkgs/3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-terraform-1-3-7,
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
      terraform-1-3-7 = import nixpkgs-terraform-1-3-7 {inherit system;};
    };

    setup = {
      hostname,
      dpi,
      polybar_dpi,
      font_size,
      scratch_res,
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
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                ${username} = import ./home/home.nix {
                  inherit
                    pkgs
                    lib
                    pkgs-custom
                    hostname
                    username
                    theme
                    polybar_dpi
                    font_size
                    scratch_res
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
        scratch_res = "2880x1800+0+0";
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
        scratch_res = "1440x900+0+0";
        brain_backup = true;
        main_monitor = "eDP-1";
        monitor_prefix = "DP";
      };
    };
  };
}
