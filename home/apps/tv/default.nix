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
              "rg"
            ];
          };
          preview = {
            command = "bat -n --color=always '{strip_ansi|split:\\::0}'";
            offset = "{strip_ansi|split:\\::1}";
          };
          source = {
            command = [
              "fd '.norg' ."
              "rg . --no-heading --line-number --colors 'match:fg:white' --colors 'path:fg:blue' --color=always"
            ];
            ansi = true;
            output = "{strip_ansi|split:\\::..2}";
          };
          keybindings = {
            ctrl-e = "actions:edit";
          };
          preview = {
            env = {
              BAT_THEME = "ansi";
            };
          };
          ui = {
            preview_panel = {
              header = "{strip_ansi|split:\\::..2}";
            };
          };
          actions = {
            edit = {
              description = "Edit file in editor at line";
              command = "nvim '+{strip_ansi|split:\\::1}' '{strip_ansi|split:\\::0}'";
              mode = "execute";
            };
          };
        };
        busted = {
          metadata = {
            description = "A channel to select a busted test.";
            name = "busted";
            requirements = [
              "busted"
              "bat"
              "rg"
            ];
          };
          preview = {
            command = "bat -n --color=always '{strip_ansi|split:\\::0}'";
            offset = "{strip_ansi|split:\\::1}";
          };
          source = {
            command = [
              "rg . -g '{tests,specs}/**/*.lua' -e 'it|describe|context|insulate|expose' --no-heading --line-number --colors 'match:fg:white' --colors 'path:fg:blue' --color=always"
            ];
            ansi = true;
            output = "{strip_ansi}";
          };
          keybindings = {
            enter = "actions:print";
            ctrl-r = "actions:run";
          };
          preview = {
            env = {
              BAT_THEME = "ansi";
            };
          };
          ui = {
            preview_panel = {
              header = "{strip_ansi|split:\\::..2}";
            };
          };
          actions = {
            print = {
              description = "Run the test(s)";
              command = "luajit ~/.local/share/scripts/tv-action-busted-run.lua echo '{strip_ansi}'";
              mode = "execute";
            };
            run = {
              description = "Run the test(s)";
              command = "luajit ~/.local/share/scripts/tv-action-busted-run.lua run '{strip_ansi}'";
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
    ".local/share/scripts/tv-action-busted-run.lua" = {
      source = ./scripts/tv-action-busted-run.lua;
    };
  };
}
