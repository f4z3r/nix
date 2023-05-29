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
    theme = "light";  # one of "light" or "dark"
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
    setup = {
      hostname,
      dpi,
      polybar_dpi,
      font_size,
      scratch_res,
      brain_backup,
    }: lib.nixosSystem {
      inherit system;
      specialArgs = { inherit system username hostname dpi brain_backup; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              ${username} = import ./home/home.nix {
                inherit pkgs lib hostname username theme polybar_dpi font_size scratch_res;
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
      };
      "nix" = setup {
        hostname = "nix";
        dpi = 91;
        polybar_dpi = 65;
        font_size = 11;
        scratch_res = "1280x800+0+0";
        brain_backup = false;
      };
    };
  };
}


