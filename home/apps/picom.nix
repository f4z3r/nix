{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-jonaburg;
    backend = "glx";
    vSync = true;

    shadow = false;
    shadowOpacity = 0.75;
    fade = true;
    fadeDelta = 5;

    settings = {
      daemon = true;
      use-damage = false;
      resize-damage = 1;
      refresh-rate = 0;
      corner-radius = 10;
      round-borders = 10;
      rounded-corners-exclude = [
        "class_g = 'Polybar'"
      ];

      # Animations Pijulius
      animations = true;
      animation-window-mass = 0.5;
      animation-for-open-window = "zoom";
      animation-stiffness = 350;
      animation-clamping = false;
      fade-out-step = 1;

      # Animations Jonaburg
      transition-length = 300;
      transition-pow-x = 0.5;
      transition-pow-y = 0.5;
      transition-pow-w = 0.5;
      transition-pow-h = 0.5;
      size-transition = true;

      # Extras
      detect-rounded-corners = true;
      detect-client-opacity = false;
      detect-transient = true;
      detect-client-leader = false;
      mark-wmwim-focused = true;
      mark-ovredir-focues = true;
      unredir-if-possible = true;
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
    };
  };
}
