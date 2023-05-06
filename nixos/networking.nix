{ config, pkgs, hostname, ... }:
{
  networking = {
    hostName = "${hostname}";

    networkmanager.enable = true;

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
      interfaces.wlp0s20f3 = {
        allowedTCPPorts = [ 8080 ];
      };
    };
  };
}
