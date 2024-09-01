{
  pkgs,
  theme,
  font_size,
  ...
}: let
  fg =
    if theme == "dark"
    then "d4be98"
    else "654735";
  bg =
    if theme == "dark"
    then "282828"
    else "fbf1c7";
  black =
    if theme == "dark"
    then "3C3836"
    else "FBF1C7";
  red =
    if theme == "dark"
    then "ea6962"
    else "c14a4a";
  green =
    if theme == "dark"
    then "a9b665"
    else "6c782e";
  yellow =
    if theme == "dark"
    then "D8A657"
    else "D79921";
  blue =
    if theme == "dark"
    then "7daea3"
    else "45707a";
  magenta =
    if theme == "dark"
    then "d3869b"
    else "945e80";
  cyan =
    if theme == "dark"
    then "89b482"
    else "4c7a5d";
  white =
    if theme == "dark"
    then "D4BE98"
    else "7C6F64";
  b_black =
    if theme == "dark"
    then "928374"
    else "928374";
  b_red =
    if theme == "dark"
    then "FB4934"
    else "9D0006";
  b_green =
    if theme == "dark"
    then "B8BB26"
    else "79740E";
  b_yellow =
    if theme == "dark"
    then "FABD2F"
    else "B57614";
  b_blue =
    if theme == "dark"
    then "83A598"
    else "076678";
  b_magenta =
    if theme == "dark"
    then "D3869B"
    else "8F3F71";
  b_cyan =
    if theme == "dark"
    then "8EC07C"
    else "427B58";
  b_white =
    if theme == "dark"
    then "EBDBB2"
    else "3C3836";
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
        background = bg;
        foreground = fg;
        # flash=7f7f00
        # flash-alpha=0.5
        ## Normal/regular colors (color palette 0-7)
        regular0 = black;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = magenta;
        regular6 = cyan;
        regular7 = white;
        ## Bright colors (color palette 8-15)
        bright0 = b_black;
        bright1 = b_red;
        bright2 = b_green;
        bright3 = b_yellow;
        bright4 = b_blue;
        bright5 = b_magenta;
        bright6 = b_cyan;
        bright7 = b_white;
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
        jump-labels = "${black} ${magenta}"; # black-on-purple
        # scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
        # search-box-no-match=<regular0> <regular1>  # black-on-red
        # search-box-match=<regular0> <regular3>     # black-on-yellow
        urls = magenta;
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
