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
        ui = {
          theme = "gruvbox-${colors.theme}";
        };
        keybindings = {
          ctrl-l = "cycle_sources";
          ctrl-s = "";
          ctrl-u = "select_prev_history";
          ctrl-d = "select_next_history";
        };
      };
      channels = {
        norg = {
          metadata = {
            description = "A channel to select norg files.";
            name = "norg";
            requirements = [
              "fd"
              "bat"
            ];
          };
          preview = {
            command = "bat -n --color=always '{}'";
          };
          source = {
            command = "fd '.*\.norg$' ~/notes/";
          };
        };
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
}
