{
  config,
  pkgs,
  hostname,
  ...
}: {
  networking = {
    hostName = "${hostname}";

    networkmanager.enable = true;

    hosts = {
      "127.0.0.1" = [ "grafana.localhost" ];
    };

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
      interfaces.wlp0s20f3 = {
        allowedTCPPorts = [8080];
        # needed for chromecast on brave
        allowedUDPPortRanges = [
          {
            from = 32768;
            to = 60999;
          }
        ];
      };
    };
  };
}
