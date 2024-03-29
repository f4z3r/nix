{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern"];
      styles = {
        "unknown-token" = "fg=red,dim,bold";
        "reserved-word" = "fg=red";
        "alias" = "fg=27";
        "suffix-alias" = "fg=27";
        "global-alias" = "fg=27";
        "builtin" = "fg=96";
        "function" = "fg=174,bold";
        "command" = "fg=blue";
        "precommand" = "fg=magenta,bold";
        "commandseparator" = "fg=52";
        "hashed-command" = "fg=blue";
        "autodirectory" = "fg=green";
        "path" = "fg=green";
        "path_prefix" = "fg=77";
        "globbing" = "fg=green,bold";
        "history-expansion" = "fg=red";
        "command-substitution" = "fg=blue";
        "command-substitution-delimiter" = "fg=52";
        "process-substitution" = "fg=blue";
        "process-substitution-delimiter" = "fg=52";
        "single-hyphen-option" = "fg=magenta";
        "double-hyphen-option" = "fg=magenta";
        "back-quoted-argument" = "fg=blue";
        "back-quoted-argument-unclosed" = "fg=red,dim";
        "back-quoted-argument-delimiter" = "fg=52";
        "single-quoted-argument" = "fg=3";
        "single-quoted-argument-unclosed" = "fg=red,dim";
        "double-quoted-argument" = "fg=3";
        "double-quoted-argument-unclosed" = "fg=red,dim";
        "dollar-quoted-argument" = "fg=cyan,bold";
        "dollar-quoted-argument-unclosed" = "fg=red,dim";
        "rc-quote" = "fg=3,bold";
        "dollar-double-quoted-argument" = "fg=cyan,bold";
        "back-double-quoted-argument" = "fg=cyan";
        "back-dollar-quoted-argument" = "fg=cyan";
        "assign" = "dim";
        "redirection" = "fg=red";
        "comment" = "fg=8";
        "named-fd" = "fg=58";
        "numeric-fd" = "fg=58";
        "arg0" = "fg=blue";
        "default" = "none";
        "bracket-level-1" = "fg=178";
        "bracket-level-2" = "fg=133";
        "bracket-level-3" = "fg=229";
        "bracket-level-4" = "fg=103";
        "cursor-matchingbracket" = "fg=green,bold";
        "bracket-error" = "bg=black,bold";
      };
      patterns = {"sudo rm *" = "fg=white,bold,bg=red";};
    };
  };
}
