{
  pkgs,
  theme,
  font_size,
  ...
}: let
  colors =
    if theme == "dark"
    then {
      foreground = "d4be98";
      background = "282828";
      normal = {
        black = "3c3836";
        red = "ea6962";
        green = "a9b665";
        yellow = "d8a657";
        blue = "7daea3";
        magenta = "d3869b";
        cyan = "89b482";
        white = "d4be98";
      };
      bright = {
        black = "928374";
        red = "fb4934";
        green = "b8bb26";
        yellow = "fabd2f";
        blue = "83a598";
        magenta = "d3869b";
        cyan = "8ec07c";
        white = "ebdbb2";
      };
    }
    else {
      foreground = "654735";
      background = "fbf1c7";
      normal = {
        black = "fbf1c7";
        red = "c14a4a";
        green = "6c782e";
        yellow = "d79921";
        blue = "45707a";
        magenta = "945e80";
        cyan = "4c7a5d";
        white = "7c6f64";
      };
      bright = {
        black = "928374";
        red = "9d0006";
        green = "79740e";
        yellow = "b57614";
        blue = "076678";
        magenta = "8f3f71";
        cyan = "427b58";
        white = "3c3836";
      };
    };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font Mono:size=${toString font_size}:style=SemiBold,Regular";
        locked-title = true;
      };
      url = {
        label-letters = "arsneiogmwfpluy";
      };
      colors = {
        # alpha=1.0
        inherit (colors) background foreground;
        # flash=7f7f00
        # flash-alpha=0.5
        ## Normal/regular colors (color palette 0-7)
        regular0 = colors.normal.black;
        regular1 = colors.normal.red;
        regular2 = colors.normal.green;
        regular3 = colors.normal.yellow;
        regular4 = colors.normal.blue;
        regular5 = colors.normal.magenta;
        regular6 = colors.normal.cyan;
        regular7 = colors.normal.white;
        ## Bright colors (color palette 8-15)
        bright0 = colors.bright.black;
        bright1 = colors.bright.red;
        bright2 = colors.bright.green;
        bright3 = colors.bright.yellow;
        bright4 = colors.bright.blue;
        bright5 = colors.bright.magenta;
        bright6 = colors.bright.cyan;
        bright7 = colors.bright.white;
        ## dimmed colors (see foot.ini(5) man page)
        # dim0=<not set>
        # ...
        # dim7=<not-set>
        ## The remaining 256-color palette
        # 16 = <256-color palette #16>
        # ...
        # 255 = <256-color palette #255>
        ## Misc colors
        # selection-foreground=<inverse foreground/background>
        # selection-background=<inverse foreground/background>
        jump-labels = "${colors.normal.black} ${colors.normal.magenta}"; # black-on-purple
        # scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
        # search-box-no-match=<regular0> <regular1>  # black-on-red
        # search-box-match=<regular0> <regular3>     # black-on-yellow
        urls = colors.normal.magenta;
      };
      key-bindings = {
        scrollback-up-page = "none";
        scrollback-up-half-page = "Page_Up";
        scrollback-up-line = "Up";
        scrollback-down-page = "none";
        scrollback-down-half-page = "Page_Down";
        scrollback-down-line = "Down";
        scrollback-home = "none";
        scrollback-end = "End";
        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
        primary-paste = "none";
        search-start = "none";
        font-increase = "Control+Up";
        font-decrease = "Control+Down";
        font-reset = "Control+equal";
        spawn-terminal = "none";
        minimize = "none";
        maximize = "none";
        fullscreen = "none";
        pipe-visible = "none";
        pipe-scrollback = "none";
        pipe-selected = "none";
        pipe-command-output = "none";
        show-urls-launch = "Control+Shift+o";
        show-urls-copy = "none";
        show-urls-persistent = "none";
        prompt-prev = "none";
        prompt-next = "none";
        unicode-input = "none";
        noop = "none";
      };
      search-bindings = {
        cancel = "Escape";
        commit = "Return";
        find-prev = "Control+r";
        find-next = "Control+s";
        cursor-left = "Left";
        cursor-left-word = "none";
        cursor-right = "Right";
        cursor-right-word = "none";
        cursor-home = "none";
        cursor-end = "none";
        delete-prev = "BackSpace";
        delete-prev-word = "none";
        delete-next = "Delete";
        delete-next-word = "none";
        extend-char = "none";
        extend-to-word-boundary = "none";
        extend-to-next-whitespace = "none";
        extend-line-down = "none";
        extend-backward-char = "none";
        extend-backward-to-word-boundary = "none";
        extend-backward-to-next-whitespace = "none";
        extend-line-up = "none";
        clipboard-paste = "none";
        primary-paste = "none";
        unicode-input = "none";
        scrollback-up-page = "none";
        scrollback-up-half-page = "none";
        scrollback-up-line = "none";
        scrollback-down-page = "none";
        scrollback-down-half-page = "none";
        scrollback-down-line = "none";
        scrollback-home = "none";
        scrollback-end = "none";
      };
      url-bindings = {
        cancel = "Escape";
        toggle-url-visible = "t";
      };
    };
  };
}
