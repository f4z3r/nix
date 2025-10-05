{
  lib,
  pkgs,
  hostname,
  usernames,
  secrets,
  ...
}: {
  imports = [
    (import ./networking.nix {inherit lib hostname;})
    (import ./clamav.nix {inherit pkgs usernames;})
    (import ./openvpn {inherit secrets;})
  ];

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gtk2;
      };
    };
  };

  security = {
    polkit.enable = true;
    pam.makeHomeDir.umask = "0077";
  };
}
