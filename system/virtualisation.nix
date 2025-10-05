{...}: {
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      daemon.settings = {
        features = {
          buildkit = true;
        };
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
