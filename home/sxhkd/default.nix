{ pkgs, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = let mod = "alt"; alt = "control"; in {
      # rofi launcher
      "${mod} + space" = "${pkgs.rofi}/bin/rofi -combi-modi window,drun -show combi";

      # launch terminal
      "${mod} + Return" = "${pkgs.wezterm}/bin/wezterm start ${pkgs.tmux}/bin/tmux";

      # quit / powermenu
      "${mod} + q" = "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu";

      # fullscreen
      "${mod} + f" = "${pkgs.bspwm}/bin/bspc node -t fullscreen";


      # open clipboard selector
      "${mod} + c" = ''${pkgs.rofi}/bin/rofi -modi "clipboard:greenclip print" -show clipboard '{cmd}' '';

      # close / kill client
      "${mod} + {_,shift + }w" = "${pkgs.bspwm}/bin/bspc node -{c,k}";

      # move between clients/swap clients
      "${mod} + {_,shift + }{h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";

      # focus on the given desktop
      "${mod} + {1-9,0}" = "${pkgs.bspwm}/bin/bspc desktop -f '^{1-9,10}'";

      # move to given desktop (and follow)
      "${mod} + shift + {1-9,0}" = "${pkgs.bspwm}/bin/bspc node -d '^{1-9,10}' --follow";

      # move to other monitor (and follow)
      "${mod} + m" = "${pkgs.bspwm}/bin/bspc node -m last --follow";

      # layouts
      "${mod} + s : t" = "${pkgs.bsp-layout}/bin/bsp-layout set tall";
      "${mod} + s : w" = "${pkgs.bsp-layout}/bin/bsp-layout set wide";
      "${mod} + s : e" = "${pkgs.bsp-layout}/bin/bsp-layout set grid";
      "${mod} + s : o" = "${pkgs.bsp-layout}/bin/bsp-layout set tiled";

      # resize
      "${mod} + r : {h,j,k,l}" = ''
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
      "XF86AudioPlay" = "${pkgs.mpc-cli}/bin/mpc toggle";

      # music control
      "${mod} + Right" = "${pkgs.mpc-cli}/bin/mpc next";
      "${mod} + Left" = "${pkgs.mpc-cli}/bin/mpc prev";

      # launchers
      "${mod} + ${alt} + w" = "${pkgs.brave}/bin/brave";
      "${mod} + ${alt} + p" = "${pkgs.uair}/bin/uairctl toggle";
      "${mod} + ${alt} + b" = ''${pkgs.rofi-rbw}/bin/rofi-rbw --keybindings="Enter:type:password'';
    };
  };

  home.file = {
    ".config/sxhkd/scripts/bspwm-scratchpad" = {
      source = ./scripts/bspwm-scratchpad;
      executable = true;
    };
  };
}
