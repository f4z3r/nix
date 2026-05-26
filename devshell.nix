{pkgs}: let
  format = pkgs.writeShellScriptBin "format" ''
    alejandra .
    prettier --ignore-unknown -w  .
  '';
  check = pkgs.writeShellScriptBin "check" ''
    alejandra -c .
    prettier --ignore-unknown -c  .
  '';
  switch = pkgs.writeShellScriptBin "switch" ''
    sudo nixos-rebuild switch --impure --flake .#
  '';
  boot = pkgs.writeShellScriptBin "boot" ''
    sudo nixos-rebuild boot --impure --flake .#
  '';
in
  pkgs.mkShell {
    name = "devshell";

    buildInputs = [
      pkgs.alejandra
      pkgs.prettier
      format
      check
      switch
      boot
    ];
  }
