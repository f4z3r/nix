{
  lib,
  pkgs,
  pkgs-custom,
  theme,
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
      skd = ''z "$(fd -t d -c always -L -H . ./ | sk --ansi)"'';
      ska = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}"' '';
      ag = ''ag --hidden --ignore .git --ignore .cache --color'';
      l = ''eza -F -a'';
      ll = ''eza -aglF --git'';
      cp = "xcp";
      erd = "erd -IHl";
      k = ''kubectl'';
      kn = ''kubens'';
      kc = ''kubectx'';
      ks = ''stern'';
      tree = ''tree -C'';
      ip = ''ip -c'';
      feh = ''feh -Fx'';
      pdf = ''mupdf'';
      lg = ''lazygit'';
      grep = ''grep --color=auto'';
      egrep = ''egrep --color=auto'';
      fgrep = ''fgrep --color=auto'';
      nix-shell = ''nix-shell --run fish'';
      wall = ''swww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
      ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --exclude '/.**' --exclude '**/.**' --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';
      jwt = ''wl-paste | step crypto jwt inspect --insecure | jq'';
      imv = ''imv -b ffffff'';
      proxy = ''ssh -p 2222 -i ~/.ssh/proxy_connection 192.168.1.40'';
      tunnel = ''ssh -p 2222 -ND 9191 -i ~/.ssh/proxy_connection 192.168.1.40'';
      cash = ''fava ~/notes/resources/accounts.beancount'';
    };
    shellInit = ''
      set -x NIX_THEME "${theme}"
      set -x NIXPKGS_ALLOW_UNFREE 1
      set -x D2_LAYOUT "elk"
      set -x D2_THEME "200"
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
