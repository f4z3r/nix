{ config, pkgs, username, ... }:
{
  services.restic = {
    backups.second-brain = {
      repository = "rclone:gdrive:sb";
      initialize = true;
      passwordFile = "/etc/nixos/restic-password";
      paths = [
        "/home/${username}/Documents/sb"
      ];
      timerConfig = {
        OnCalendar = "daily";
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
  };
}
