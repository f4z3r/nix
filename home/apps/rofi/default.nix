{
  pkgs,
  theme,
  ...
}: let
  colors = import ./../../../theme.nix {inherit theme;};
in {
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    terminal = "${pkgs.ghostty}/bin/ghostty";
    theme = "improved";
  };

  home.file = {
    ".local/share/rofi/themes/improved.rasi" = {
      source = ./themes/improved.rasi;
    };
    ".local/share/rofi/themes/shared/colors.rasi" = {
      text = ''
        * {
            background:     ${colors.background}FF;
            background-alt: ${colors.background-alt}FF;
            foreground:     ${colors.foreground}FF;
            selected:       ${colors.aqua}FF;
            active:         ${colors.green}FF;
            urgent:         ${colors.red}FF;
        }
      '';
    };
    ".local/share/rofi/themes/shared/fonts.rasi" = {
      source = ./themes/shared/fonts.rasi;
    };
  };
}
