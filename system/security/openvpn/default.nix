{secrets, ...}: {
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

  environment = {
    etc = {
      "nixos/vpn/ca" = {
        mode = "0600";
        text = secrets.vpn.ca;
      };
      "nixos/vpn/tls-auth" = {
        mode = "0600";
        text = secrets.vpn.tls-auth;
      };
      "nixos/vpn/account.cred" = {
        mode = "0600";
        text = secrets.vpn.creds;
      };
    };
  };
}
