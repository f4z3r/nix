{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      username = "f4z3r";
      theme = "dark"; # one of "light" or "dark"
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      inherit (nixpkgs) lib;

      setup = { hostname, dpi, polybar_dpi, font_size, scratch_res, brain_backup
        , main_monitor, monitor_prefix }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit system username hostname dpi brain_backup main_monitor
              monitor_prefix;
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
                    inherit pkgs lib hostname username theme polybar_dpi
                      font_size scratch_res main_monitor monitor_prefix;
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
          scratch_res = "2560x1600+0+0";
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
          scratch_res = "1280x800+0+0";
          brain_backup = true;
          main_monitor = "eDP-1";
          monitor_prefix = "DP";
        };
      };
    };
}
