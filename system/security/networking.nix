{
  lib,
  hostname,
  ...
}: {
  networking = {
    hostName = "${hostname}";
    useDHCP = lib.mkDefault true;

    networkmanager.enable = true;

    hosts = {
      "127.0.0.1" = [
        "example.com"
      ];
    };

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
      interfaces.wlp0s20f3 = {
        allowedTCPPorts = [8080];
        # needed for chromecast on brave
        # allowedUDPPortRanges = [
        #   {
        #     from = 32768;
        #     to = 60999;
        #   }
        # ];
      };
    };
  };
  security.pki.certificates = [
  ];
}
