{
  config,
  pkgs,
  ...
}: {
  services.openvpn = {
    servers = {
      ch = {
        config = builtins.readFile ./servers/ch.protonvpn.net.udp.ovpn;
        autoStart = true;
        updateResolvConf = true;
      };
      de = {
        config = builtins.readFile ./servers/de.protonvpn.net.udp.ovpn;
        autoStart = false;
        updateResolvConf = true;
      };
      uk = {
        config = builtins.readFile ./servers/uk.protonvpn.net.udp.ovpn;
        autoStart = false;
        updateResolvConf = true;
      };
    };
  };
}
