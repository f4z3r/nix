{ pkgs, username, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = let
      super = "super";
      mod = "alt";
      alt = "control";
    in {
      # using alt + control + o as leader key
      # rofi launcher
      "${mod} + space" =
        "${pkgs.rofi}/bin/rofi -combi-modi window,drun -show combi";
      "${mod} + ${alt} + o ; p" =
        "${pkgs.rofi-rbw}/bin/rofi-rbw -a copy -t password";

      # launch terminal
      "${mod} + Return" =
        "${pkgs.wezterm}/bin/wezterm start ${pkgs.tmux}/bin/tmux";

      # quit / powermenu
      "${mod} + ${alt} + o ; q" =
        "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
      "${mod} + ${alt} + o ; l" = "${pkgs.xsecurelock}/bin/xsecurelock";
      "${mod} + ${alt} + o ; s" = "${pkgs.systemd}/bin/systemctl suspend";

      # fullscreen
      "${mod} + ${alt} + f" = "${pkgs.bspwm}/bin/bspc node -t '~fullscreen'";

      # close / kill client
      "${mod} + ${alt} + o ; {_,shift + }w" =
        "${pkgs.bspwm}/bin/bspc node -{c,k}";

      # move between clients/swap clients
      "${mod} + {_,shift + }{h,n,k,l}" =
        "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";

      # focus on the given desktop
      "${mod} + {1-9,0}" = "${pkgs.bspwm}/bin/bspc desktop -f '^{1-9,10}'";
      # focus on the last desktop
      "${mod} + Tab" = "${pkgs.bspwm}/bin/bspc desktop -f last";

      # move to given desktop (and follow)
      "${mod} + shift + {1-9,0}" =
        "${pkgs.bspwm}/bin/bspc node -d '^{1-9,10}' --follow";

      # move to other monitor (and follow)
      "${mod} + ${alt} + o ; m" =
        "${pkgs.bspwm}/bin/bspc node -m last --follow";

      # resize
      "${mod} + ${alt} + r + {Left,Down,Up,Right}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "${mod} + ${alt} + r + shift + {Left,Down,Up,Right}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

      # preselect new window
      "${super} + o ; {h,n,k,l}" =
        "${pkgs.bspwm}/bin/bspc node --presel-dir '~{west,south,north,east}'";
      "${super} + o ; {Left,Down,Up,Right}" =
        "${pkgs.bspwm}/bin/bspc node --presel-dir '~{west,south,north,east}'";
      "${super} + o ; space" = "${pkgs.bspwm}/bin/bspc node -p cancel";

      # screenshots
      "Print" = "${pkgs.flameshot}/bin/flameshot gui";

      # quake
      "${alt} + Return" = ''
        ~/.config/sxhkd/scripts/bspwm-scratchpad "quake" "wezterm start --class quake -- tmux"'';

      # brightness control
      "XF86MonBrightnessDown" =
        "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 5%-";
      "XF86MonBrightnessUp" =
        "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +5%";

      # volume control
      "XF86AudioRaiseVolume" =
        "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%+";
      "XF86AudioLowerVolume" =
        "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%-";
      "XF86AudioMute" = "${pkgs.alsa-utils}/bin/amixer -q sset Master toggle";
      "XF86AudioMicMute" =
        "${pkgs.luajit}/bin/luajit /home/${username}/.config/sxhkd/scripts/toggle-mute.lua";
      "XF86AudioPlay" = "${pkgs.mpc-cli}/bin/mpc toggle";

      # music control
      "${super} + Right" = "${pkgs.mpc-cli}/bin/mpc next";
      "${super} + Left" = "${pkgs.mpc-cli}/bin/mpc prev";

      # launchers
      "${mod} + ${alt} + l ; w" =
        "${pkgs.luajit}/bin/luajit /home/${username}/.config/sxhkd/scripts/fuzzy-bookmarks.lua";
      "${mod} + ${alt} + l ; p" = "${pkgs.uair}/bin/uairctl toggle";
      "${mod} + ${alt} + l ; m" =
        "${pkgs.wezterm}/bin/wezterm start ${pkgs.ncmpcpp}/bin/ncmpcpp";
      "${mod} + ${alt} + l ; i" = "/home/${username}/.local/bin/songinfo";
    };
  };

  home.file = {
    ".config/sxhkd/scripts/bspwm-scratchpad" = {
      source = ./scripts/bspwm-scratchpad;
      executable = true;
    };
    ".config/sxhkd/scripts/toggle-mute.lua" = {
      source = ./scripts/toggle-mute.lua;
    };
    ".config/sxhkd/scripts/fuzzy-bookmarks.lua" = {
      source = ./scripts/fuzzy-bookmarks.lua;
    };
  };
}
