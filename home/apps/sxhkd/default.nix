{
  pkgs,
  username,
  ...
}: {
  services.sxhkd = {
    enable = true;
    keybindings = let
      super = "super";
      mod = "alt";
      alt = "control";
    in {
      # using alt + control + o as leader key
      # rofi launcher
      "${mod} + space" = "${pkgs.rofi}/bin/rofi -combi-modi window,drun -show combi";

      # launch terminal (shift modifies)
      "${super} + Return" = "${pkgs.wezterm}/bin/wezterm start ${pkgs.tmux}/bin/tmux";
      "${mod} + a" = "${pkgs.bspwm}/bin/bspc desktop -f '^1'";
      "${mod} + r" = "${pkgs.bspwm}/bin/bspc desktop -f '^2'";
      "${mod} + s" = "${pkgs.bspwm}/bin/bspc desktop -f '^3'";
      "${mod} + t" = "${pkgs.bspwm}/bin/bspc desktop -f '^4'";
      "${mod} + g" = "${pkgs.bspwm}/bin/bspc desktop -f '^5'";
      "${mod} + q" = "${pkgs.bspwm}/bin/bspc desktop -f '^6'";
      "${mod} + w" = "${pkgs.bspwm}/bin/bspc desktop -f '^7'";
      "${mod} + f" = "${pkgs.bspwm}/bin/bspc desktop -f '^8'";
      "${mod} + p" = "${pkgs.bspwm}/bin/bspc desktop -f '^9'";
      "${mod} + b" = "${pkgs.bspwm}/bin/bspc desktop -f '^10'";
      "${mod} + shift + a" = "${pkgs.bspwm}/bin/bspc node -d '^1' --follow";
      "${mod} + shift + r" = "${pkgs.bspwm}/bin/bspc node -d '^2' --follow";
      "${mod} + shift + s" = "${pkgs.bspwm}/bin/bspc node -d '^3' --follow";
      "${mod} + shift + t" = "${pkgs.bspwm}/bin/bspc node -d '^4' --follow";
      "${mod} + shift + g" = "${pkgs.bspwm}/bin/bspc node -d '^5' --follow";
      "${mod} + shift + q" = "${pkgs.bspwm}/bin/bspc node -d '^6' --follow";
      "${mod} + shift + w" = "${pkgs.bspwm}/bin/bspc node -d '^7' --follow";
      "${mod} + shift + f" = "${pkgs.bspwm}/bin/bspc node -d '^8' --follow";
      "${mod} + shift + p" = "${pkgs.bspwm}/bin/bspc node -d '^9' --follow";
      "${mod} + shift + b" = "${pkgs.bspwm}/bin/bspc node -d '^10' --follow";
      "${mod} + Tab" = "${pkgs.bspwm}/bin/bspc desktop -f last";
      "${mod} + {_,shift + }{h,n,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";
      "${mod} + shift + o" = "${pkgs.bspwm}/bin/bspc node -m last --follow";
      "${mod} + shift + x " = "${pkgs.bspwm}/bin/bspc node -c";
      "${mod} + shift + y " = "${pkgs.bspwm}/bin/bspc node -t '~fullscreen'";

      # cnotrl for laucher (password, terminal, powermenu, sofa)
      "${mod} + ${alt} + x" = "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
      "${mod} + ${alt} + o" = "/etc/profiles/per-user/f4z3r/bin/sofa";
      "${mod} + ${alt} + w" = "${pkgs.luajit}/bin/luajit /home/${username}/.config/sxhkd/scripts/fuzzy-bookmarks.lua";
      "${mod} + ${alt} + p" = "${pkgs.rofi-rbw}/bin/rofi-rbw -a copy -t password";
      "${mod} + ${alt} + s" = "${pkgs.systemd}/bin/systemctl suspend";
      "${mod} + ${alt} + l" = "${pkgs.xsecurelock}/bin/xsecurelock";

      # resize
      "${mod} + ${alt} + r + {Left,Down,Up,Right}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "${mod} + ${alt} + r + shift + {Left,Down,Up,Right}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

      # preselect new window
      "${super} + o ; {h,n,k,l}" = "${pkgs.bspwm}/bin/bspc node --presel-dir '~{west,south,north,east}'";
      "${super} + o ; {Left,Down,Up,Right}" = "${pkgs.bspwm}/bin/bspc node --presel-dir '~{west,south,north,east}'";
      "${super} + o ; space" = "${pkgs.bspwm}/bin/bspc node -p cancel";

      # screenshots
      "Print" = "${pkgs.flameshot}/bin/flameshot gui";

      # quake
      "${alt} + Return" = ''
        ~/.config/sxhkd/scripts/bspwm-scratchpad "quake" "wezterm start --class quake -- tmux new -s quake"'';

      # brightness control
      "XF86MonBrightnessDown" = "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 5%-";
      "XF86MonBrightnessUp" = "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +5%";

      # volume control
      "XF86AudioRaiseVolume" = "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%+";
      "XF86AudioLowerVolume" = "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%-";
      "XF86AudioMute" = "${pkgs.alsa-utils}/bin/amixer -q sset Master toggle";
      "XF86AudioMicMute" = "${pkgs.luajit}/bin/luajit /home/${username}/.config/sxhkd/scripts/toggle-mute.lua";
      "XF86AudioPlay" = "${pkgs.mpc-cli}/bin/mpc toggle";

      # music control
      "${super} + Right" = "${pkgs.mpc-cli}/bin/mpc next";
      "${super} + Left" = "${pkgs.mpc-cli}/bin/mpc prev";

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
