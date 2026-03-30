{
  pkgs,
  pkgs-stable,
  lib,
  stdenv,
  pkgs-custom,
  scale,
  username,
  resolution,
  main_monitor,
  monitor_prefix,
  colors,
  ...
}: {
  imports = [
    (import ./hyprland/default.nix {
      inherit pkgs pkgs-stable username resolution scale main_monitor monitor_prefix colors;
    })
    (import ./rofi/default.nix {inherit pkgs colors;})
    (import ./tv/default.nix {inherit pkgs;})
    (import ./git/default.nix {inherit pkgs colors;})
    (import ./lazygit.nix {inherit pkgs colors;})
    (import ./tmux/default.nix {inherit pkgs lib stdenv colors;})
    (import ./fish/default.nix {inherit pkgs colors;})
    (import ./starship.nix {inherit pkgs lib;})
    (import ./nvim/default.nix {inherit pkgs pkgs-stable pkgs-custom;})
    (import ./broot.nix {inherit pkgs colors;})
    (import ./k9s.nix {inherit pkgs colors;})
    (import ./mpd/default.nix {inherit pkgs username;})
  ];

  programs = {
    ghostty = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      installBatSyntax = true;
      installVimSyntax = true;
      clearDefaultKeybinds = true;
      settings = {
        font-family = "MonaspiceNe Nerd Font Mono";
        font-variation = "wght=450";
        font-family-italic = "MonaspiceAr Nerd Font Mono";
        font-variation-italic = "wght=450";
        font-family-bold-italic = "MonaspiceAr Nerd Font Mono";
        font-feature = [
          "+calt"
          "+ss01"
          "+ss02"
          "+ss03"
          "+ss04"
          "+ss05"
          "+ss06"
          "+ss07"
          "+ss08"
          "+ss09"
          "+ss10"
          "+liga"
        ];
        cursor-invert-fg-bg = true;
        cursor-style-blink = false;
        cursor-style = "block";
        window-decoration = "none";
        link-url = true;
        theme =
          if colors.theme == "dark"
          then "Gruvbox Dark"
          else "Gruvbox Light";
        keybind = [
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+down=decrease_font_size:1"
          "ctrl+up=increase_font_size:1"
          "ctrl+equal=reset_font_size"
          "ctrl+period=reload_config"
        ];
        config-file = "?/home/${username}/.config/ghostty/overrides";
      };
    };

    bat = {
      enable = true;
      config = {
        style = "numbers,changes,header";
      };
    };

    gpg = {
      enable = true;
    };
  };
}
