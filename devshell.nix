{pkgs}: let
  format = pkgs.writeShellScriptBin "format" ''
    alejandra .
    prettier --ignore-unknown -w  .
  '';
  check = pkgs.writeShellScriptBin "check" ''
    alejandra -c .
    prettier --ignore-unknown -c  .
  '';
in
  pkgs.mkShell {
    name = "devshell";

    buildInputs = [
      pkgs.alejandra
      pkgs.prettier
      format
      check
    ];
  }
