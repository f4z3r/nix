{
  description = "My NixOS setups";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # fix due to bug not enabling the grammar
    norg-meta.url = "github:nvim-neorg/tree-sitter-norg-meta";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    neorg-overlay,
    norg-meta,
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
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    inherit (nixpkgs) lib;
    pkgs-custom = {
        norg-meta = norg-meta.defaultPackage.${system};
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
            pkgs-stable
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
                      pkgs-stable
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
