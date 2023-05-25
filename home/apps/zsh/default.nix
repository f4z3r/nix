{ lib, pkgs, theme, lua-packages, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 10000;
      share = true;
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
    defaultKeymap = "viins";
    dirHashes = {
      "docs" = "$HOME/Documents";
      "down" = "$HOME/Downloads";
    };
    initExtraFirst = builtins.readFile ./config.zsh;
    initExtra = ''
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
    shellGlobalAliases = {
      "sys" = ''systemctl'';
      "sysl" = ''systemctl list-units'';
      "syse" = ''systemctl is-enabled'';
      "sysa" = ''systemctl is-active'';
      "syss" = ''systemctl status'';
      "syst" = ''systemctl start'';
      "sysp" = ''systemctl stop'';
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
    };
    sessionVariables = {
      GREP_COLORS = "mt=01;33:ms=01;33:mc=01;33:sl=:cx=:fn=35:ln=32:bn=32:se=36";
      MANPAGER = "sh -c 'col -bx | bat --theme=default -l man -p'";
      NIX_THEME = "${theme}";
      NIXPKGS_ALLOW_UNFREE = 1;
      LUA_CPATH = "${lib.concatStringsSep ";" (map pkgs.luajitPackages.getLuaCPath lua-packages)}";
      LUA_PATH = "${lib.concatStringsSep ";" (map pkgs.luajitPackages.getLuaPath lua-packages)}";
    };
  };
}
