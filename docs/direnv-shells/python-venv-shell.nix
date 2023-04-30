with import <nixpkgs> {};
let
  python-packages = ps: with ps; [
    pip
    virtualenv
    setuptools
  ];
  enhanced-python = pkgs.python39.withPackages python-packages;
in
  pkgs.mkShell rec {
    name = "pip-shell";
    packages = [
      enhanced-python
      # add system packages here
    ];
    shellHook = ''
      test -d ./.venv || virtualenv ./.venv
      source ./.venv/bin/activate
      pip install --upgrade pip
    '';
  }

# vim:shiftwidth=2:tabstop=2
