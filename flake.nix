{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    neorg-overlay,
    ghostty,
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
      inherit ghostty;
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
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              neorg-overlay.overlays.default
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
        monitoring = false;
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
