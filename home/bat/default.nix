{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      style = "numbers,changes,header";
    };
  };
}
