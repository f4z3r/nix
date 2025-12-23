{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      debugpy
      pip
      virtualenv
      setuptools
      presenterm-export
      black
    ];
in
  pkgs.python313.withPackages python-packages
