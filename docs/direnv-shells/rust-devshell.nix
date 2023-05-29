{
  description = "Rust nightly Dev Shell";
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # rust overlay
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake utility tooling
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, fenix, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        with pkgs; {
           packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
           nixpkgs.overlays = [ fenix.overlays.default ];
          devShell = mkShell {
            buildInputs = with pkgs; [
              (fenix.complete.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
              rust-analyzer-nightly
            ];
          };
        });
}
