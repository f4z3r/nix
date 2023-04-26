{ pkgs, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = let mod = "alt"; alt = "ctlr"; in {
      # rofi launcher
      "${mod} + space" = "rofi -combi-modi window,drun -show combi";
      # launch terminal
      "${mod} + Return" = "wezterm start tmux";
      # reload configuration
      "${mod} + ${alt} + r" = "pkill -USR1 -x sxhkd";
      # quit powermenu
      "${mod} + ${alt} + q" = "rofi -show p -modi p:rofi-power-menu";
      # next layout
      "${mod} + f" = "bspc desktop -l next";
      # open clipboard selector
      "${mod} + c" = ''rofi -modi "clipboard:greenclip print" -show clipboard '{cmd}' '';
      # close / kill client
      "${mod} + {_,shift + }q" = "bspc node -{c,k}";
      # move between clients/move clients
      "${mod} + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
      # focus on the given desktop
      "${mod} + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
    };
  };
}
