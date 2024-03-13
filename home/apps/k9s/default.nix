{
  pkgs,
  theme,
  ...
}: let
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
            fgColor = foreground;
            bgColor = background;
            logoColor = blue;
          };
          prompt = {
            fgColor = foreground;
            bgColor = background;
            suggestColor = orange;
          };
          info = {
            fgColor = magenta;
            bgColor = background;
            sectionColor = foreground;
          };
          dialog = {
            fgColor = foreground;
            bgColor = background;
            buttonFgColor = foreground;
            buttonBgColor = magenta;
            buttonFocusFgColor = selection;
            buttonFocusBgColor = cyan;
            labelFgColor = orange;
            fieldFgColor = foreground;
          };
          frame = {
            border = {
              fgColor = selection;
              bgColor = background;
              focusColor = comment;
            };
            menu = {
              fgColor = foreground;
              bgColor = background;
              keyColor = magenta;
              numKeyColor = magenta;
            };
            crumbs = {
              fgColor = comment;
              bgColor = background;
              activeColor = green;
            };
            status = {
              bgColor = background;
              newColor = cyan;
              modifyColor = blue;
              addColor = green;
              errorColor = red;
              highlightcolor = orange;
              killColor = comment;
              completedColor = comment;
            };
            title = {
              fgColor = foreground;
              bgColor = background;
              highlightColor = orange;
              counterColor = blue;
              filterColor = magenta;
            };
          };
          views = {
            charts = {
              defaultDialColors = [blue red];
              defaultChartColors = [blue red];
            };
            table = {
              fgColor = foreground;
              bgColor = background;
              markColor = magenta;
              header = {
                fgColor = magenta;
                bgColor = background;
                sorterColor = selection;
              };
            };
            xray = {
              fgColor = foreground;
              bgColor = background;
              cursorColor = comment;
              graphicColor = orange;
              showIcons = true;
            };
            yaml = {
              bgColor = background;
              keyColor = blue;
              colonColor = orange;
              valueColor = foreground;
            };
            logs = {
              fgColor = foreground;
              bgColor = background;
              indicator = {
                fgColor = magenta;
                bgColor = background;
              };
            };
          };
        };
      };
    };
  };
}
