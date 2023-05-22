{
  description = "Python 3.9.2 Dev Shell";
  inputs = {
    nixpkgs.url = "nixpkgs/release-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    # find hash with https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable
    nixpkgs-python.url = "github:NixOS/nixpkgs/0ffaecb6f04404db2c739beb167a5942993cfd87";
    # flake utility tooling
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-python, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          pkgs-unstable = import nixpkgs-unstable { inherit system; };
          pkgs-python = import nixpkgs-python { inherit system; };
          python-packages = ps: with ps; [
            pip
            virtualenv
            setuptools
          ];
          enhanced-python = pkgs-python.python39Full.withPackages python-packages;
        in
        with pkgs;
        {
          devShell = mkShell {
            buildInputs = [
              gnumake
              enhanced-python
            ];
            shellHook = ''
              test -d ./.venv || virtualenv ./.venv
              source ./.venv/bin/activate
            '';
          };
        });
}
