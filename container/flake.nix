{
  description = "My Home Manager setup";

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

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    neorg-overlay,
    norg-meta,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
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
      theme = "dark"; # one of "light" or "dark"
    in {
      legacyPackages = {
        homeConfigurations = {
          "root" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              (import ./home.nix {
                inherit
                  pkgs
                  pkgs-stable
                  lib
                  stdenv
                  pkgs-custom
                  theme
                  ;
              })
            ];

            # nixpkgs.overlays = [
            #   neorg-overlay.overlays.default
            # ];
          };
        };
      };
    });
}
