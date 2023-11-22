{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-allusive;
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

      animations = true;
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";
      animation-open-exclude = [
        "class_g = 'Polybar'"
      ];
      animation-dampening = 10;
      animation-stiffness = 200;
      animation-clamping = true;
      fade-out-step = 1;

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
