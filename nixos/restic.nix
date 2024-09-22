{
  usernames,
  brain_backup,
  ...
}: {
  services.restic =
    if brain_backup
    then {
      backups.second-brain = {
        repository = "rclone:gdrive:notes";
        initialize = true;
        passwordFile = "/etc/nixos/restic-password";
        paths =
          builtins.concatMap (x: [
            "/home/${x}/notes"
          ])
          usernames;
        timerConfig = {
          OnCalendar = "daily";
          RandomizedDelaySec = "20m";
          Persistent = true;
        };
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];
        rcloneConfigFile = /etc/nixos/rclone.conf;
        rcloneOptions = {
          bwlimit = "10M";
          drive-use-trash = "true";
        };
      };
    }
    else {
    };
}
