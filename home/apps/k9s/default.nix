{
  pkgs,
  theme,
  ...
}: let
  colors = import ./../../../theme.nix {inherit theme;};
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

    views = {
      "kafka.strimzi.io/v1beta2/kafkatopics" = {
        columns = [
          "NAME"
          "CLUSTER"
          "PARTITIONS"
          "REPLICATION FACTOR"
          "READY"
          "TOPIC NAME:.spec.topicName"
        ];
      };
      sortColumn = "TOPIC NAME:asc";
    };
  };
}
