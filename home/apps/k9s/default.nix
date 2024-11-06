{
  pkgs,
  theme,
  ...
}: let
  colors =
    if theme == "dark"
    then {
      foreground = "#d4be98";
      background = "#282828";
      current_line = "#d4be98";
      selection = "#928374";
      comment = "#665c54";
      cyan = "#89b482";
      green = "#a9b665";
      orange = "#e78a4e";
      magenta = "#d3869b";
      blue = "#7daea3";
      red = "#ea6962";
    }
    else {
      foreground = "#654735";
      background = "#fbf1c7";
      current_line = "#654735";
      selection = "#928374";
      comment = "#d5c4a1";
      cyan = "#4c7a5d";
      green = "#6c782e";
      orange = "#c35e0a";
      magenta = "#945e80";
      blue = "#45707a";
      red = "#c14a4a";
    };
in {
  programs.k9s = {
    enable = true;

    settings = {
      k9s = {
        ui = {
          headless = true;
          enableMouse = false;
          crumbsless = true;
          logoless = true;
          noIcons = false;
        };
        readOnly = false;
        refreshRate = 2;
        maxConnRetry = 5;
        noExitOnCtrlC = true;
        skipLatestRevCheck = false;
        logger = {
          tail = 100;
          buffer = 5000;
          sinceSeconds = 60;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
        screenDumpDir = "/tmp/k9s-screens-jakob";
        currentContext = "ccp21-n";
        currentCluster = "ccp21-n";
        clusters = {};
      };
    };

    skins = {
      gruvbox = {
        k9s = {
          body = {
            fgColor = colors.foreground;
            bgColor = colors.background;
            logoColor = colors.blue;
          };
          prompt = {
            fgColor = colors.foreground;
            bgColor = colors.background;
            suggestColor = colors.orange;
          };
          info = {
            fgColor = colors.magenta;
            bgColor = colors.background;
            sectionColor = colors.foreground;
          };
          dialog = {
            fgColor = colors.foreground;
            bgColor = colors.background;
            buttonFgColor = colors.background;
            buttonBgColor = colors.magenta;
            buttonFocusFgColor = colors.background;
            buttonFocusBgColor = colors.cyan;
            labelFgColor = colors.orange;
            fieldFgColor = colors.foreground;
          };
          frame = {
            border = {
              fgColor = colors.selection;
              bgColor = colors.background;
              focusColor = colors.comment;
            };
            menu = {
              fgColor = colors.foreground;
              bgColor = colors.background;
              keyColor = colors.magenta;
              numKeyColor = colors.magenta;
            };
            crumbs = {
              fgColor = colors.comment;
              bgColor = colors.background;
              activeColor = colors.green;
            };
            status = {
              bgColor = colors.background;
              newColor = colors.cyan;
              modifyColor = colors.blue;
              addColor = colors.green;
              errorColor = colors.red;
              highlightcolor = colors.orange;
              killColor = colors.comment;
              completedColor = colors.comment;
            };
            title = {
              fgColor = colors.foreground;
              bgColor = colors.background;
              highlightColor = colors.orange;
              counterColor = colors.blue;
              filterColor = colors.magenta;
            };
          };
          views = {
            charts = {
              defaultDialColors = [colors.blue colors.red];
              defaultChartColors = [colors.blue colors.red];
            };
            table = {
              fgColor = colors.foreground;
              bgColor = colors.background;
              markColor = colors.magenta;
              header = {
                fgColor = colors.magenta;
                bgColor = colors.background;
                sorterColor = colors.selection;
              };
            };
            xray = {
              fgColor = colors.foreground;
              bgColor = colors.background;
              cursorColor = colors.background;
              graphicColor = colors.orange;
              showIcons = true;
            };
            yaml = {
              bgColor = colors.background;
              keyColor = colors.blue;
              colonColor = colors.orange;
              valueColor = colors.foreground;
            };
            logs = {
              fgColor = colors.foreground;
              bgColor = colors.background;
              indicator = {
                fgColor = colors.magenta;
                bgColor = colors.background;
              };
            };
          };
        };
      };
    };
  };
}
