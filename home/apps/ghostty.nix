{
  pkgs,
  pkgs-custom,
  theme,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = pkgs-custom.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
        if theme == "dark"
        then "GruvboxDark"
        else "GruvboxLight";
      keybind = [
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+down=decrease_font_size:1"
        "ctrl+up=increase_font_size:1"
        "ctrl+equal=reset_font_size"
      ];
    };
  };
}
