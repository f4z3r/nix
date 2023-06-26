{ pkgs, username, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = let super = "super"; mod = "alt"; alt = "control"; in {
      # rofi launcher
      "${mod} + space" = "${pkgs.rofi}/bin/rofi -combi-modi window,drun -show combi";
      "${mod} + ${alt} + o" = ''${pkgs.rofi-rbw}/bin/rofi-rbw -a copy -t password'';

      # launch terminal
      "${mod} + Return" = "${pkgs.wezterm}/bin/wezterm start ${pkgs.tmux}/bin/tmux";

      # quit / powermenu
      "${super} + q" = "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
      "${super} + shift + q" = "${pkgs.xsecurelock}/bin/xsecurelock";

      # fullscreen
      "${super} + f" = "${pkgs.bspwm}/bin/bspc node -t '~fullscreen'";

      # close / kill client
      "${super} + {_,shift + }w" = "${pkgs.bspwm}/bin/bspc node -{c,k}";

      # move between clients/swap clients
      "${mod} + {_,shift + }{h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";

      # focus on the given desktop
      "${mod} + {1-9,0}" = "${pkgs.bspwm}/bin/bspc desktop -f '^{1-9,10}'";

      # move to given desktop (and follow)
      "${mod} + shift + {1-9,0}" = "${pkgs.bspwm}/bin/bspc node -d '^{1-9,10}' --follow";

      # move to other monitor (and follow)
      "${super} + m" = "${pkgs.bspwm}/bin/bspc node -m last --follow";

      # resize
      "${super} + r : {h,j,k,l}" = ''
        STEP=20; SELECTION={1,2,3,4}; \
        ${pkgs.bspwm}/bin/bspc node -z $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
        ${pkgs.bspwm}/bin/bspc node -z $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)
      '';

      # quake
      "${alt} + Return" = ''~/.config/sxhkd/scripts/bspwm-scratchpad "quake" "wezterm start --class quake -- tmux"'';

      # brightness control
      "XF86MonBrightnessDown" = "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 5%-";
      "XF86MonBrightnessUp" = "${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +5%";

      # volume control
      "XF86AudioRaiseVolume" = "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%+";
      "XF86AudioLowerVolume" = "${pkgs.alsa-utils}/bin/amixer -q sset Master 1%-";
      "XF86AudioMute" = "${pkgs.alsa-utils}/bin/amixer -q sset Master toggle";
      "XF86AudioMicMute" = ''~/.config/sxhkd/scripts/toggle-mute'';
      "XF86AudioPlay" = "${pkgs.mpc-cli}/bin/mpc toggle";

      # music control
      "${super} + Right" = "${pkgs.mpc-cli}/bin/mpc next";
      "${super} + Left" = "${pkgs.mpc-cli}/bin/mpc prev";

      # launchers
      "${mod} + ${alt} + w" = "${pkgs.brave}/bin/brave";
      "${mod} + ${alt} + p" = "${pkgs.uair}/bin/uairctl toggle";
      "${mod} + ${alt} + m" = "${pkgs.wezterm}/bin/wezterm start ${pkgs.ncmpcpp}/bin/ncmpcpp";
      "${super} + i" = "/home/${username}/.local/bin/songinfo";
    };
  };

  home.file = {
    ".config/sxhkd/scripts/bspwm-scratchpad" = {
      source = ./scripts/bspwm-scratchpad;
      executable = true;
    };
    ".config/sxhkd/scripts/toggle-mute" = {
      source = ./scripts/toggle-mute;
      executable = true;
    };
  };
}
