{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      debugpy
      pip
      virtualenv
      setuptools
      python-lsp-server
      pylsp-rope
      presenterm-export
      black
    ];
in
  pkgs.python313.withPackages python-packages
