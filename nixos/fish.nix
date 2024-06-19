{
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };
}
