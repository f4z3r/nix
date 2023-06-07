{ lib, pkgs, theme, lua-packages, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
    '';
    environmentVariables = {
      GREP_COLORS = "mt=01;33:ms=01;33:mc=01;33:sl=:cx=:fn=35:ln=32:bn=32:se=36";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      NIX_THEME = "${theme}";
      NIXPKGS_ALLOW_UNFREE = "1";
      LUA_CPATH = "${lib.concatStringsSep ";" (map pkgs.luajitPackages.getLuaCPath lua-packages)}";
      LUA_PATH = "${lib.concatStringsSep ";" (map pkgs.luajitPackages.getLuaPath lua-packages)}";
    };
    shellAliases = {
      "t" = ''nvim ~/Documents/sb/todo/scratch.org'';
      "rt" = ''cd $( if git rev-parse --show-toplevel &> /dev/null; then; git rev-parse --show-toplevel; else; echo "."; fi; )'';
      "ag" = ''ag --hidden --ignore .git --ignore .cache --color'';
      "sk" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1'';
      "ska" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}"' '';
      "ck" = ''cd "$(fd -t d -c always -L -H . ./ | sk --ansi)"'';
      "l" = ''exa -Fa'';
      "ll" = ''exa -aglF --git'';
      "cp" = "xcp";
      "erd" = "erd -IHl";
      "k" = ''kubectl'';
      "kn" = ''kubens'';
      "kc" = ''kubectx'';
      "kv" = ''k9s --headless --crumbsless'';
      "ks" = ''stern'';
      "tree" = ''tree -C'';
      "ip" = ''ip -c'';
      "feh" = ''feh -Fx'';
      "pdf" = ''mupdf'';
      "grep" = ''grep --color=auto'';
      "egrep" = ''egrep --color=auto'';
      "fgrep" = ''fgrep --color=auto'';
      "sbpull" = ''rclone sync --delete-after -P gdrive-crypt:/ ~/Documents/sb'';
      "sbpush" = ''rclone sync --delete-after -P ~/Documents/sb gdrive-crypt:/'';
    };
  };
}
