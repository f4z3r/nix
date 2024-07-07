{
  pkgs,
  pkgs-custom,
  theme,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with pkgs-custom.anyrun.packages.${pkgs.system}; [
        applications
        shell
        # randr  -- is not working at the moment
        translate
        websearch
        stdin
      ];
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      hidePluginInfo = false;
    };
    extraCss = '''';
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 5,
          terminal: Some("${pkgs.wezterm}/bin/wezterm start"),
        )
      '';
      "shell.ron".text = ''
        Config(
          prefix: ":"
        )
      '';
      "websearch.ron".text = ''
        Config(
          prefix: "?",
          engines: [DuckDuckGo],
        )
      '';
      "translate.ron".text = ''
        Config(
          prefix: ">",
          language_delimiter: ">",
          max_entries: 3,
        )
      '';
    };
  };
}
