{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";                              # Rendering either with glx or xrender. You'll know if you need to switch this.
    vSync = true;                                 # Should fix screen tearing

    #activeOpacity = 0.93;                         # Node transparency
    #inactiveOpacity = 0.93;
    #menuOpacity = 0.93;

    shadow = false;                               # Shadows
    shadowOpacity = 0.75;
    fade = true;                                  # Fade
    fadeDelta = 5;
    opacityRules = [                              # Opacity rules if transparency is prefered
    #  "100:name = 'Picture in picture'"
    #  "100:name = 'Picture-in-Picture'"
    #  "85:class_i ?= 'rofi'"
      "80:class_i *= 'discord'"
      "80:class_i *= 'emacs'"
      "80:class_i *= 'Alacritty'"
    #  "100:fullscreen"
    ];                                            # Find with $ xprop | grep "WM_CLASS"

    settings = {
      daemon = true;
      use-damage = false;                         # Fixes flickering and visual bugs with borders
      resize-damage = 1;
      refresh-rate = 0;
      corner-radius = 15;                          # Corners
      round-borders = 15;

      # Animations Pijulius
      animations = true;                          # All Animations
      animation-window-mass = 0.5;
      animation-for-open-window = "zoom";
      animation-stiffness = 350;
      animation-clamping = false;
      fade-out-step = 1;                          # Will fix random border dots from not disappearing

      # Animations Jonaburg
      transition-length = 300;
      transition-pow-x = 0.5;
      transition-pow-y = 0.5;
      transition-pow-w = 0.5;
      transition-pow-h = 0.5;
      size-transition = true;

      # Extras
      detect-rounded-corners = true;              # Below should fix multiple issues
      detect-client-opacity = false;
      detect-transient = true;
      detect-client-leader = false;
      mark-wmwim-focused = true;
      mark-ovredir-focues = true;
      unredir-if-possible = true;
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
    };                                           # Extra options for picom.conf (mostly for pijulius fork)
  };
}
