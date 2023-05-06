{ config, pkgs, username, ... }:
{
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        OnAccessIncludePath = [
          "/home/${username}/Downloads"
          "/home/${username}/Documents"
          "/home/${username}/Music"
        ];
        OnAccessPrevention = "yes";
        OnAccessExcludeUname = "clamav";
      };
    };

    updater = {
      enable = true;
      interval = "daily";
      frequency = 1;
    };
  };

  systemd.services."clamav-clamonacc" = {
    description = "ClamAV On-Access Scanner";
    documentation = [ "man:clamonacc(8)" "man:clamd.conf(5)" "https://docs.clamav.net/" ];
    requires = [ "clamav-daemon.service" ];
    after = [ "clamav-daemon.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStartPre = ''${pkgs.bash}/bin/bash -c "while [ ! -S /run/clamav/clamd.ctl ]; do sleep 1; done"'';
      ExecStart = ''${pkgs.clamav}/bin/clamonacc -F -c /etc/clamav/clamd.conf --move /root/quarantine  --fdpass --allmatch'';
    };
  };
}
