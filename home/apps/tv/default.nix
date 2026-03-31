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
        dirs = {
          metadata = {
            description = "A channel to select from directories";
            name = "dirs";
            requirements = [
              "fd"
            ];
          };
          preview = {
            command = "eza -la --color=always '{}'";
          };
          source = {
            command = [
              "fd -t d"
              "fd -t d --hidden"
            ];
          };
          keybindings = {
            ctrl-e = "actions:edit";
            ctrl-space = "actions:go_to_parent_dir";
          };
          actions = {
            edit = {
              description = "Edit directory";
              command = "nvim '{}'";
              mode = "execute";
            };
            go_to_parent_dir = {
              description = "Open tv in parent dir.";
              command = "tv dirs ..";
              mode = "execute";
            };
          };
        };
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
          keybindings = {
            ctrl-e = "actions:edit";
          };
          actions = {
            edit = {
              description = "Edit directory";
              command = "nvim '{}'";
              mode = "execute";
            };
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
