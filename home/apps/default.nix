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
      inherit pkgs username resolution scale main_monitor monitor_prefix colors;
    })
    (import ./rofi/default.nix {inherit pkgs colors;})
    (import ./git/default.nix {inherit pkgs colors;})
    (import ./lazygit.nix {inherit colors;})
    (import ./tmux/default.nix {inherit pkgs lib stdenv colors;})
    (import ./fish/default.nix {inherit pkgs colors;})
    ./starship.nix
    (import ./nvim/default.nix {inherit pkgs pkgs-stable pkgs-custom;})
    (import ./broot.nix {inherit colors;})
    (import ./k9s.nix {inherit colors;})
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
        font-family = "FiraCode Nerd Font Mono Med";
        font-family-bold = "FiraCode Nerd Font Mono Bold";
        font-family-bold-italic = "FiraCode Nerd Font Mono Bold";
        font-family-italic = "FiraCode Nerd Font Mono Light";
        font-feature = "+ss02";
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
        ];
      };
    };

    bat = {
      enable = true;
      config = {
        theme = "gruvbox-${colors.theme}";
        style = "numbers,changes,header";
      };
    };

    gpg = {
      enable = true;
    };
  };
}
