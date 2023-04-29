{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        syntax-theme = "gruvbox-dark";
        true-color = "always";
        plus-style = "syntax #012800";
        minus-style = "syntax #340001";
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    userName = "Jakob Beckmann";
    userEmail = "jakobbeckmann@pm.me";

    extraConfig = {
      core = {
        editor = "${pkgs.neovim}/bin/nvim";
      };
      advice = {
        skippedCherryPicks = false;
      };
      log = {
        date = "format:%Y-%m-%d %H:%M";
      };
      push = {
        autoSetupRemote = true;
      };
      checkout = {
        defaultRemote = "origin";
      };
      pull = {
        ff = "only";
        rebase = true;
      };
    };

    ignores = [
      "tags"
      "tags.temp"
      "tags.lock"
      ".mypy_cache/"
      ".direnv/"
      ".ruff_cache/"
      ".pytest_cache/"
      "__pycache__/"
      ".*.un~"
      ".nvimlog"
      ".tool-versions"
      "/worktrees/"
    ];

    aliases = {
      "f" = ''fetch -q'';
      "b" = ''branch -vv'';
      "ba" = ''branch -vva'';
      "d" = ''diff'';
      "aa" = ''add .'';
      "a" = ''add'';
      "acs" = ''commit -aS -m'';
      "cc" = ''commit -S -m'';
      "ca" = ''commit --amend -S -C HEAD'';
      "ce" = ''commit --amend -S -m'';
      "co" = ''checkout'';
      "sw" = ''switch'';
      "re" = ''reset'';
      "s"  ='' status -sb'';
      "st" = ''stash list'';
      "sh" = ''stash show --full-diff'';
      "lg" = ''log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit'';
      "rs" = ''reflog show'';
      "ph" = ''push -q'';
      "phf" = ''push -q --force-with-lease'';
      "pl" = ''pull -q'';
      "w" = ''worktree'';
      "wa" = ''worktree add'';
      "wl" = ''worktree list'';
      "bc" = ''!git branch -vva --color=always | grep -v '/HEAD\\s' | sk --ansi --tac | sed 's/^..//' | awk '{print $1}' | sed 's|^remotes/[^/]*/||' | xargs git switch'';
      "bp" = ''!git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" {print $1}' | xargs -r git branch -D'';
    };
  };
}
