{
  pkgs,
  pkgs-stable,
  lib,
  stdenv,
  pkgs-custom,
  scale,
  username,
  resolution,
  main_monitor,
  monitor_prefix,
  colors,
  ...
}:
assert lib.asserts.assertOneOf "theme" colors.theme [
  "dark"
  "light"
]; {
  imports = [
    (import ./profiles/dev.nix {inherit lib pkgs pkgs-stable pkgs-custom username colors stdenv;})
    (import ./profiles/desktop.nix {inherit pkgs pkgs-stable username main_monitor monitor_prefix resolution scale colors;})
    ./profiles/host.nix
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };
}
