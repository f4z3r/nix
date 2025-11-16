{
  pkgs,
  colors,
  ...
}: {
  programs.atuin = {
    enable = true;
    settings = {
      dialect = "uk";
      auto_sync = false;
      update_check = false;
      enter_accept = true;
      filter_mode = "session";
      style = "full";
      keymap_mode = "emacs";
    };
    enableFishIntegration = true;
    enableBashIntegration = true;
    daemon.enable = false;
  };
  programs.fish = {
    enable = true;
    shellAbbrs = {
      sys = ''systemctl'';
    };
    shellAliases = {
      rt = ''z $( if git rev-parse --show-toplevel &> /dev/null; git rev-parse --show-toplevel; else; echo "."; end )'';
      sk = ''sk -m --color="dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1"'';
      ska = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}"' '';
      l = ''eza -F -a'';
      ll = ''eza -aglF --git'';
      cp = "xcp";
      erd = "erd -IHl";
      k = ''kubectl'';
      kn = ''kubens'';
      kc = ''kubectx'';
      tree = ''tree -C'';
      pdf = ''mupdf'';
      lg = ''lazygit'';
      grep = ''grep --color=auto'';
      egrep = ''egrep --color=auto'';
      fgrep = ''fgrep --color=auto'';
      nix-shell = ''nix-shell --run fish'';
      wall = ''swww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
      ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --exclude '/.**' --exclude '**/.**' --exclude '**/tags' --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';
      jwt = ''wl-paste | step crypto jwt inspect --insecure | jq'';
      imv = ''imv -b ffffff'';
    };
    shellInit = ''
      set -x NIX_THEME "${colors.theme}"
      set -x NIXPKGS_ALLOW_UNFREE 1
      set -x D2_LAYOUT "elk"
      set -x D2_THEME "200"
      umask 0077
    '';
    interactiveShellInit = builtins.readFile ./config.fish;
    plugins = with pkgs.fishPlugins; [
      {
        name = gruvbox.pname;
        inherit (gruvbox) src;
      }
      {
        name = autopair.pname;
        inherit (autopair) src;
      }
    ];
  };
  home.file.".config/fish/completions/wash.fish" = {
    source = ./completions/wash.fish;
  };
}
