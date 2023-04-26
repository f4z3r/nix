{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 10000;
      share = false;
    };
    defaultKeymap = "viins";
    dirHashes = {
      "docs" = "$HOME/Documents";
      "down" = "$HOME/Downloads";
    };
    initExtraFirst = builtins.readFile ./config.zsh;
    initExtra = ''
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
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
      "rt" = ''cd $( if git rev-parse --show-toplevel &> /dev/null; then; git rev-parse --show-toplevel; else; echo "."; fi; )' '';
      "ag" = ''ag --hidden --ignore .git --ignore .cache --color'';
      "sk" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1'';
      "ska" = ''sk -m --color=dark,hl:3,spiller:2,fg+:9,hl+:3,selected:6,query:5,matched_bg:-1 --ansi -i -c 'ag "{}\"' '';
      "ck" = ''cd "$(fd -t d -c always -L -H . ./ | sk --ansi)"'';
      "l" = ''exa -Fa'';
      "ll" = ''exa -alF --git'';
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
      LESS_TERMCAP_mb = "$'\\E[01;31m'";
      LESS_TERMCAP_md = "$'\\E[01;\\38;5;74m'";
      LESS_TERMCAP_me = "$'\\E[0m'";
      LESS_TERMCAP_se = "$'\\E[0m'";
      LESS_TERMCAP_so = "$'\\E[31;1;4m'";
      LESS_TERMCAP_ue = "$'\\E[0m'";
      LESS_TERMCAP_us = "$'\\E[04;3\\8;5;146m'";
      LESS_TERMCAP_mr = "$'\\E[01;33m'";
      MANPAGER = "sh -c 'col -bx | bat --theme=gruvbox-dark -l man -p'";
    };
  };
}
