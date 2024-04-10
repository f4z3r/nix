{
  lib,
  pkgs,
  theme,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    antidote = {
      enable = true;
      plugins = [
        "marlonrichert/zsh-autocomplete"
      ];
    };
    autosuggestion = {
      enable = true;
    };
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
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
    ];
    defaultKeymap = "viins";
    initExtraFirst = builtins.readFile ./config.zsh;
    initExtra = ''
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      path=("$HOME/.local/bin/" "$HOME/.luarocks/bin/" $path)
      export PATH
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
      "rt" = ''cd $( if git rev-parse --show-toplevel &> /dev/null; then; git rev-parse --show-toplevel; else; echo "."; fi; )'';
      "ag" = ''ag --hidden --ignore .git --ignore .cache --color'';
      "sk" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1'';
      "ska" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}"' '';
      "ck" = ''cd "$(fd -t d -c always -L -H . ./ | sk --ansi)"'';
      "l" = ''eza -F -a'';
      "ll" = ''eza -aglF --git'';
      "cp" = "xcp";
      "erd" = "erd -IHl";
      "k" = ''kubectl'';
      "kn" = ''kubens'';
      "kc" = ''kubectx'';
      "ks" = ''stern'';
      "tree" = ''tree -C'';
      "ip" = ''ip -c'';
      "feh" = ''feh -Fx'';
      "pdf" = ''mupdf'';
      "grep" = ''grep --color=auto'';
      "egrep" = ''egrep --color=auto'';
      "fgrep" = ''fgrep --color=auto'';
      "npl" = ''rclone sync -u --delete-after -P gdrive-crypt:/ ~/notes'';
      "nph" = ''rclone sync -u --delete-after -P ~/notes gdrive-crypt:/'';
    };
    sessionVariables = {
      GREP_COLORS = "mt=01;33:ms=01;33:mc=01;33:sl=:cx=:fn=35:ln=32:bn=32:se=36";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      NIX_THEME = "${theme}";
      MANROFFOPT = "-c";
      NIXPKGS_ALLOW_UNFREE = 1;
      D2_LAYOUT = "elk";
      D2_THEME = "200";
    };
  };
}
