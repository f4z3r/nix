{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
