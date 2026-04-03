{
  pkgs,
  colors,
  ...
}: {
  programs = {
    television = {
      enable = true;
      # see: https://alexpasmantier.github.io/television/user-guide/configuration
      settings = {
        keybindings = {
          ctrl-l = "cycle_sources";
          ctrl-s = "";
          ctrl-u = "select_prev_history";
          ctrl-d = "select_next_history";
        };
      };
      channels = {
        dirs = builtins.fromTOML (builtins.readFile ./cable/dirs.toml);
        norg = builtins.fromTOML (builtins.readFile ./cable/norg.toml);
        channels = builtins.fromTOML (builtins.readFile ./cable/channels.toml);
        busted = builtins.fromTOML (builtins.readFile ./cable/busted.toml);
      };
    };

    sesh = {
      enable = true;
      settings = {
        dir_length = 2;
        blacklist = ["quake" "popup-.*"];
        session = [
          {
            name = "notes";
            path = "~/notes/";
            startup_command = "nvim";
          }
        ];
      };
    };
  };

  home.file = {
    ".local/share/scripts/tv-action-busted-run.lua" = {
      source = ./scripts/tv-action-busted-run.lua;
    };
  };
}
