{
  lib,
  pkgs,
  theme,
  ...
}: {
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
      grep = ''grep --color=auto'';
      egrep = ''egrep --color=auto'';
      fgrep = ''fgrep --color=auto'';
      nix-shell = ''nix-shell --run fish'';
      npl = ''rclone sync -u --delete-after -P gdrive-crypt:/ ~/notes'';
      nph = ''rclone sync -u --delete-after -P ~/notes gdrive-crypt:/'';
    };
    shellInit = ''
      set -U NIX_THEME "${theme}"
      set -U NIXPKGS_ALLOW_UNFREE 1
      set -U D2_LAYOUT "elk"
      set -U D2_THEME "200"
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
      {
        name = fifc.pname;
        inherit (fifc) src;
      }
    ];
  };
}
