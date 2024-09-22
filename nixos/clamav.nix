{
  config,
  pkgs,
  usernames,
  ...
}: {
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        OnAccessIncludePath =
          builtins.concatMap (x: [
            "/home/${x}/Downloads"
            "/home/${x}/Documents"
            "/home/${x}/Music"
            "/home/${x}/tmp"
          ])
          usernames;
        OnAccessPrevention = "yes";
        OnAccessExcludeUname = "clamav";
        #   VirusEvent =
        #     ''/run/wrappers/bin/sudo -u ${username} ''
        #     + ''DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 ''
        #     + ''${pkgs.libnotify}/bin/notify-send -u critical -i clamav ''
        #     + ''"Virus Found" "Virus $CLAM_VIRUSEVENT_VIRUSNAME found in ''
        #     + ''$CLAM_VIRUSEVENT_FILENAME.\nFile moved to /root/quarantine."'';
      };
    };

    updater = {
      enable = true;
      interval = "daily";
      frequency = 1;
    };

    fangfrisch = {
      enable = true;
      interval = "daily";
    };
  };

  systemd.services."clamav-clamonacc" = {
    description = "ClamAV On-Access Scanner";
    documentation = ["man:clamonacc(8)" "man:clamd.conf(5)" "https://docs.clamav.net/"];
    requires = ["clamav-daemon.service"];
    after = ["clamav-daemon.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStartPre = ''${pkgs.bash}/bin/bash -c "while [ ! -S /run/clamav/clamd.ctl ]; do sleep 1; done"'';
      ExecStart = ''${pkgs.clamav}/bin/clamonacc -F -c /etc/clamav/clamd.conf --move /root/quarantine  --fdpass --allmatch'';
      ExecReload = ''${pkgs.coreutils}/bin/kill -USR2 $MAINPID'';
    };
  };
}
