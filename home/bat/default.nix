{ pkgs, theme, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-${theme}";
      style = "numbers,changes,header";
    };
  };
}
