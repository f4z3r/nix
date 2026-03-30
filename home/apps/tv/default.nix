{pkgs, ...}: {
  programs = {
    television = {
      enable = true;
      # see: https://alexpasmantier.github.io/television/user-guide/configuration
      settings = {
        ui = {
          theme = "gruvbox-dark"; # TODO: f4z3r - update to dynamic
        };
      };
      channels = {
        norg = {
          metadata = {
            description = "A channel to select norg files and provide links.";
            name = "norg";
            requirements = [
              "fd"
              "bat"
              "luajit"
            ];
          };
          preview = {
            command = "bat -n --color=always '{}'";
          };
          source = {
            command = "fd '.*\.norg$' ~/notes/";
          };
          keybindings = {
            enter = "actions:link";
          };
          actions = {
            link = {
              description = "Prints the norg link to the file.";
              command = "luajit ~/.local/bin/tv-norg-action-link.lua '{}'";
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

  home.file = {
    ".local/bin/tv-norg-action-link.lua" = {source = ./scripts/tv-norg-action-link.lua;};
  };
}
